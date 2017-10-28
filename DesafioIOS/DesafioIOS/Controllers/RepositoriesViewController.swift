//
//  RepositoriesViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import SDWebImage
import SVProgressHUD

class RepositoriesViewController : UITableViewController {
    
    @IBOutlet weak var infiniteScrollingView: UIActivityIndicatorView?
    
    fileprivate(set) public var source = [Repository]()
    fileprivate(set) public var page = 1
    fileprivate(set) public var isProcessing = false
    
    fileprivate var service = RepositoryService()
    
    // Setup
    fileprivate func setup() {
        // Table cell height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 130
        
        // Infinite Scrolling
        self.infiniteScrollingView?.alpha = 0
        
        // Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = UIColor.navigationBarColor
        self.refreshControl!.attributedTitle = nil
        self.refreshControl!.addTarget(self, action: #selector(RepositoriesViewController.refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl!)
        
        // Load Repositories
        self.triggerRefreshControl()
    }
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == MainStoryboard.Segue.toPullRequest {
            let vc = segue.destination as! PullRequestsViewController
            vc.repository = sender as? Repository
        }
    }
    
    // MARK: - Observers & Notifications
    public func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(RepositoriesViewController.notificationIsReachable(n:)), name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RepositoriesViewController.notificationNotReachable(n:)), name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    public func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    @objc func notificationIsReachable(n: Notification) {
        if  self.source.count == 0 {
            if !self.isProcessing {
                self.triggerRefreshControl()
            }
        }
    }
    
    @objc func notificationNotReachable(n: Notification) {
        SVProgressHUD.showError(withStatus: "Você está desconectado")
    }
    
    // MARK: - Data Methods
    @objc func refresh() {
        if !self.isProcessing {
            self.isProcessing = true
            
            // Reset
            self.page = 1
            
            // Re-fetch
            self.fetchData() {
                [weak self] in
                if  let this = self {
                    this.refreshControl?.endRefreshing()
                }
            }
        }
    }
    
    func triggerRefreshControl() {
        if  let safeControl = self.refreshControl {
            safeControl.beginRefreshing()
            self.tableView.setContentOffset(CGPoint(x: 0, y: -safeControl.frame.size.height), animated: true)
        }
        self.refresh()
    }
    
    func fetchData(completion: (() -> Void)?=nil) {
        
        service.load(page: self.page, succeed: {
            [weak self] results in
            
            if  let this = self {
                if  this.page == 1 {
                    this.source = []
                }
                this.source.append(contentsOf: results)
                this.tableView.reloadData()
                this.isProcessing = false
                completion?()
            }
            
        }) { [weak self] errorDescription in
            // Show error
            SVProgressHUD.showError(withStatus: errorDescription)
            if  let this = self {
                this.refreshControl?.endRefreshing()
                this.isProcessing = false
            }
        }
    }
}

// MARK: - Infinite Scrolling
extension RepositoriesViewController {
    
    func triggerInfiniteScrolling(completion: (()->Void)?=nil) {
        if !self.isProcessing {
            self.isProcessing = true
            self.infiniteScrollingView?.alpha = 1
            self.page += 1
            self.fetchData() {
                [weak self] in
                if  let this = self {
                    this.infiniteScrollingView?.alpha = 0
                    completion?()
                }
            }
        }
        else {
            completion?()
        }
    }
}

// MARK: - Table Methods
extension RepositoriesViewController {
    
    // Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.objectID, for: indexPath) as! RepositoryCell
        let object = self.source[indexPath.row]
        
        cell.fillData(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = self.source[indexPath.row]
        self.performSegue(withIdentifier: MainStoryboard.Segue.toPullRequest, sender: object)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  indexPath.row == (self.source.count - 1) {
            self.triggerInfiniteScrolling()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    
    // Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

// MARK: - Resources
class RepositoryCell : UITableViewCell {
    
    static let objectID = "repositoryCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    func fillData(object: Repository) {
        
        // Repository Data
        self.nameLabel.text = object.fullName
        self.descriptionLabel.text = object.objectDescription
        
        // Format value
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        let forksNumber = NSNumber(value: object.forks)
        let starsNumber = NSNumber(value: object.stars)
        self.forksCountLabel.text = formatter.string(from: forksNumber)
        self.starsCountLabel.text = formatter.string(from: starsNumber)
        
        // Owner Data
        if  let owner = object.owner {
            self.userNameLabel.text = owner.name
            self.userNicknameLabel.text = owner.username
            if  owner.picture != "",
                let url = URL(string: owner.picture),
                let placeholder = UIImage(named: "avatar_noimage") {
                self.userPicture.sd_setImage(with: url, placeholderImage: placeholder)
                // Image Configuration
                self.userPicture.layer.cornerRadius = 20
            }
        }
    }
}


