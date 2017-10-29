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
     * Class View Model
     */
    var viewModel = PullRequestsViewModel()
    
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
        
        // ViewModel
        viewModel.viewController = self
        
        // Title
        if  let safeRepository = viewModel.repository {
            title = safeRepository.name
            navigationItem.title = safeRepository.name
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
            let nav = segue.destination as! UINavigationController
            let vc = nav.viewControllers.first as! WebViewController
            vc.viewModel.pullRequest = sender as? PullRequest
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
    
    // MARK: - 🎃 Reachability
    
    /**
     *  addObservers()
     *  @description    Subscribes the Screen to receive Reachability events
     */
    func addObservers() {
        
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
    
    /**
     *  removeObservers()
     *  @description    Unsubscribes the Reachability events
     */
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
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

