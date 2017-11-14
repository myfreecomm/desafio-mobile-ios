//
//  PullRequestsViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

/**
 *  PullRequestsViewController
 *  @description    PullRequests list screen
 */
class PullRequestsViewController : UITableViewController, Hud {
    
    /**
     * View Model
     */
    var viewModel : PullRequestsViewModel!
    
    /**
     * Outlets
     */
    @IBOutlet weak var tableHeader : UIView?
    @IBOutlet weak var pullRequestsCountLabel : UILabel?
    
    // Setup
    
    /**
     *  setup()
     *  @description    Initial State
     */
    private func setup() {
        
        // Title
        title = viewModel.repositoryName
        navigationItem.title = viewModel.repositoryName
        
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
    
    // MARK: - 👽 Lifecycle Methods
    
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
            if  let nav = segue.destination as? UINavigationController,
                let vc = nav.viewControllers.first as? WebViewController,
                let pull = sender as? PullRequest {
                vc.viewModel = WebViewModel(pullRequest: pull)
            }
        }
    }
    
    // MARK: - 🌳 Data
    
    /**
     *  refresh()
     *  @description    Pull-to-Refresh action
     */
    @objc func refresh() {
        viewModel.refresh()
    }
    
    /**
     *  triggerRefreshControl()
     *  @description    Set the refresh control to its initial state & fires it
     */
    func triggerRefreshControl() {
        if  let safeControl = self.refreshControl {
            safeControl.beginRefreshing()
            self.tableView.setContentOffset(CGPoint(x: 0, y: -safeControl.frame.size.height), animated: true)
        }
        refresh()
    }
    
    // MARK: - 🤖 IB Actions
    
    /**
     *  actionBack()
     *  @description    Pops the current ViewController from NavigationController
     */
    @IBAction func actionBack() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    /**
     *  addObservers()
     *  @description    Subscribes the Screen to receive Reachability events
     */
    func addObservers() {
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(PullRequestsViewController.notificationIsReachable(n:)), custom: .reachable)
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(PullRequestsViewController.notificationNotReachable(n:)), custom: .notReachable)
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(PullRequestsViewController.notificationReloadData(n:)), custom: .reloadData)
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(PullRequestsViewController.notificationPreparePullsCount(n:)), custom: .preparePullsCount)
        
        NotificationCenter.default.subscribe(
            observer: self, selector: #selector(RepositoriesViewController.notificationDidReceiveError(n:)), custom: .didReceiveError)
    }
    
    /**
     *  removeObservers()
     *  @description    Unsubscribes the Reachability events
     */
    func removeObservers() {
        NotificationCenter.default.unsubscribe(observer: self)
    }
    
    // MARK: - 🎃 Reachability
    
    /**
     *  notificationIsReachable(n:)
     *  @description    Selector action for when connection is on
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationIsReachable(n: Notification) {
        guard viewModel.source.count == 0 else { return }
        if !viewModel.isProcessing {
            triggerRefreshControl()
        }
    }
    
    /**
     *  notificationNotReachable(n:)
     *  @description    Selector action for when connection is off
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationNotReachable(n: Notification) {
        errorHud("Error.YouAreOffline".localized)
    }
    
    // MARK: - 🚀 Reactions
    
    /**
     *  notificationReloadData(n:)
     *  @description    View Model's message to reload data
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationReloadData(n: Notification) {
        tableView.reloadData()
        refreshControl?.endRefreshing()
    }
    
    /**
     *  notificationPreparePullsCount(n:)
     *  @description    View Model's message to any errors received
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationPreparePullsCount(n: Notification) {
        let openText = "\(viewModel.openPullsCount) \("opened".localized)"
        let text = "\(openText) / \(viewModel.closedPullsCount) \("closed".localized)"
        let attrStr = NSMutableAttributedString(string: text)
        attrStr.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.highlightColor, range: NSMakeRange(0, openText.characters.count))
        pullRequestsCountLabel?.attributedText = attrStr
    }
    
    /**
     *  notificationDidReceiveError(n:)
     *  @description    View Model's message to any errors received
     *  @param n        NotificationCenter's notification
     */
    @objc func notificationDidReceiveError(n: Notification) {
        refreshControl?.endRefreshing()
        guard let message = n.object as? String else { return }
        errorHud(message)
    }
}

// MARK: - 📦 Table Delegate & DataSource
extension PullRequestsViewController {
    
    // Rows
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = viewModel.source[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestTableViewCell.cellIdentifier, for: indexPath) as! PullRequestTableViewCell
        cell.prepareForReuse()
        cell.configure(object: object)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = viewModel.source[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: MainStoryboard.Segue.toWebView, sender: object)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    // Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

