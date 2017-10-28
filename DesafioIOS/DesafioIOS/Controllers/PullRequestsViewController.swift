//
//  PullRequestsViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

public class PullRequestsViewController : UITableViewController, Hud {
    
    var viewModel = PullRequestsViewModel()
    
    @IBOutlet weak var tableHeader : UIView?
    @IBOutlet weak var pullRequestsCountLabel : UILabel?
    
    // Setup
    private func setup() {
        
        // ViewModel
        viewModel.viewController = self
        
        // Title
        if  let safeRepository = viewModel.repository {
            title = safeRepository.name
            navigationItem.title = safeRepository.name
        }
        
        // Table header line
        if  let header = tableHeader {
            let bottomBorder = CALayer()
            bottomBorder.frame = CGRect(x: 0, y: header.frame.size.height - 1.0, width: header.frame.size.width, height: 1)
            bottomBorder.backgroundColor = UIColor.lineColor.cgColor
            header.layer.addSublayer(bottomBorder)
        }
        
        // Open/Close repos label
        pullRequestsCountLabel?.text = ""
        
        // Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl!.tintColor = UIColor.navigationBarColor
        refreshControl!.attributedTitle = nil
        refreshControl!.addTarget(self, action: #selector(PullRequestsViewController.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        // Table cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        // Load Data
        triggerRefreshControl()
    }
    
    // MARK: - Lifecycle Methods
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.addObservers()
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeObservers()
    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == MainStoryboard.Segue.toWebView {
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! WebViewController
            vc.pullRequest = sender as? PullRequest
        }
    }
    
    // MARK: - Data Methods
    @objc func refresh() {
        viewModel.refresh()
    }
    
    func triggerRefreshControl() {
        if  let safeControl = self.refreshControl {
            safeControl.beginRefreshing()
            self.tableView.setContentOffset(CGPoint(x: 0, y: -safeControl.frame.size.height), animated: true)
        }
        refresh()
    }
    
    // MARK: - IB Actions
    @IBAction func actionBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Observers & Notifications
extension PullRequestsViewController {
    
    public func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PullRequestsViewController.notificationIsReachable(n:)),
            name: NotificationCenter.Name.Reachable,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(PullRequestsViewController.notificationNotReachable(n:)),
            name: NotificationCenter.Name.NotReachable,
            object: nil
        )
    }
    
    public func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    @objc func notificationIsReachable(n: Notification) {
        guard viewModel.source.count == 0 else { return }
        if !viewModel.isProcessing {
            triggerRefreshControl()
        }
    }
    
    @objc func notificationNotReachable(n: Notification) {
        errorHud("Você está desconectado ☹️")
    }
}

// MARK: - Table Methods
extension PullRequestsViewController {
    
    // Rows
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = viewModel.source[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.cellIdentifier, for: indexPath) as! PullRequestCell
        cell.prepareForReuse()
        cell.configure(object: object)
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = viewModel.source[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: MainStoryboard.Segue.toWebView, sender: object)
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    // Sections
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

