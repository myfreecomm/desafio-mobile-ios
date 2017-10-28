//
//  PullRequestsViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import SVProgressHUD

class PullRequestsViewController : UITableViewController {
    
    public var repository : Repository?
    
    @IBOutlet weak var tableHeader : UIView?
    @IBOutlet weak var pullRequestsCountLabel : UILabel?
    
    fileprivate(set) public var source = [PullRequest]()
    fileprivate(set) public var isProcessing = false
    fileprivate(set) public var openPullsCount = 0
    fileprivate(set) public var closedPullsCount = 0
    
    // Setup
    fileprivate func setup() {
        
        // Title
        if  let safeRepository = self.repository {
            self.title = safeRepository.name
            self.navigationItem.title = safeRepository.name
        }
        
        // Table header line
        if  let header = self.tableHeader {
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x: 0, y: header.frame.size.height - 1.0, width: header.frame.size.width, height: 1)
            bottomBorder.backgroundColor = UIColor.lineColor.cgColor
            header.layer.addSublayer(bottomBorder)
        }
        
        // Open/Close repos label
        self.pullRequestsCountLabel?.text = ""
        
        // Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = UIColor.navigationBarColor
        self.refreshControl!.attributedTitle = nil
        self.refreshControl!.addTarget(self, action: #selector(PullRequestsViewController.refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl!)
        
        // Table cell height
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 140
        
        // Load Data
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
        if  segue.identifier == MainStoryboard.Segue.toWebView {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! WebViewController
            vc.pullRequest = sender as? PullRequest
        }
    }
    
    // MARK: - Observers & Notifications
    public func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(PullRequestsViewController.notificationIsReachable(n:)), name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PullRequestsViewController.notificationNotReachable(n:)), name: NotificationCenter.Name.NotReachable, object: nil)
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
            // Re-fetch
            self.fetchData()
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
        
        if  let safeRepository = self.repository,
            let safeOwner = safeRepository.owner {
            let service = PullRequestService()
            service.load(owner: safeOwner.username, repository: safeRepository.name, succeed: {
                [weak self] results in
                
                if  let this = self {
                    // Check state
                    for pull in results {
                        // Open pulls
                        if  pull.state == "open" {
                            this.openPullsCount += 1
                        }
                        // Closed pulls
                        if  pull.state == "closed" {
                            this.closedPullsCount += 1
                        }
                    }
                    // Fill label
                    let openText = "\(this.openPullsCount) opened"
                    let text = "\(openText) / \(this.closedPullsCount) closed"
                    let attrStr = NSMutableAttributedString(string: text)
                    attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.highlightColor, range: NSMakeRange(0, openText.characters.count))
                    this.pullRequestsCountLabel?.attributedText = attrStr
                    // Fill source
                    this.source = results
                    this.tableView.reloadData()
                    this.refreshControl?.endRefreshing()
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
                completion?()
            }
        }
        else {
            SVProgressHUD.showError(withStatus: "Não foi possível carregar os dados desse repositório.")
            self.refreshControl?.endRefreshing()
            completion?()
        }
    }
    
    // MARK: - IB Actions
    @IBAction func actionBack() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Table Methods
extension PullRequestsViewController {
    
    // Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.objectID, for: indexPath) as! PullRequestCell
        let object = self.source[indexPath.row]
        
        cell.fillData(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let object = self.source[indexPath.row]
        self.performSegue(withIdentifier: MainStoryboard.Segue.toWebView, sender: object)
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
class PullRequestCell : UITableViewCell {
    
    static let objectID = "pullRequestCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    func fillData(object: PullRequest) {
        // Repository Data
        self.nameLabel.text = object.title
        self.descriptionLabel.text = object.objectDescription
        // Owner Data
        if  let owner = object.owner {
            self.userNameLabel.text = owner.name
            self.userNicknameLabel.text = owner.username
            if  owner.picture != "",
                let url = URL(string: owner.picture),
                let placeholder = UIImage(named: "avatar_noimage") {
                self.userPicture.sd_setImage(with: url, placeholderImage: placeholder)
                // Image Configuration
                self.userPicture.layer.cornerRadius = 18
                self.userPicture.layer.masksToBounds = true
            }
        }
    }
}


