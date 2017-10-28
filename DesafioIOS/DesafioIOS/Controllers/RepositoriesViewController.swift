//
//  RepositoriesViewController.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import SDWebImage

public class RepositoriesViewController : UITableViewController, Hud {
    
    var viewModel = RepositoriesViewModel()
    
    @IBOutlet weak var infiniteScrollingView: UIActivityIndicatorView?
    
    // Setup
    private func setup() {
        
        // ViewModel
        viewModel.viewController = self
        
        // Table cell height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130
        
        // Infinite Scrolling
        infiniteScrollingView?.alpha = 0
        
        // Refresh Control
        refreshControl = UIRefreshControl()
        refreshControl!.tintColor = UIColor.navigationBarColor
        refreshControl!.attributedTitle = nil
        refreshControl!.addTarget(self, action: #selector(RepositoriesViewController.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        // Load Repositories
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
        if  segue.identifier == MainStoryboard.Segue.toPullRequest {
            let vc = segue.destination as! PullRequestsViewController
            vc.viewModel.repository = sender as? Repository
        }
    }
    
    // MARK: - Data Methods
    @objc func refresh() {
        viewModel.refresh()
    }
    
    func triggerRefreshControl() {
        if  let safeControl = self.refreshControl {
            safeControl.beginRefreshing()
            tableView.setContentOffset(CGPoint(x: 0, y: -safeControl.frame.size.height), animated: true)
        }
        refresh()
    }
    
    // MARK: - Reachability
    open func addObservers() {
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RepositoriesViewController.notificationIsReachable(n:)),
            name: NotificationCenter.Name.Reachable,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(RepositoriesViewController.notificationNotReachable(n:)),
            name: NotificationCenter.Name.NotReachable,
            object: nil
        )
    }
    
    open func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.Reachable, object: nil)
        NotificationCenter.default.removeObserver(self, name: NotificationCenter.Name.NotReachable, object: nil)
    }
    
    @objc open func notificationIsReachable(n: Notification) {
        guard viewModel.source.count == 0 else { return }
        if !viewModel.isProcessing {
            triggerRefreshControl()
        }
    }
    
    @objc open func notificationNotReachable(n: Notification) {
        errorHud("Você está desconectado ☹️")
    }
}

// MARK: - Table Methods
extension RepositoriesViewController {
    
    // Rows
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let object = viewModel.source[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.cellIdentifier, for: indexPath) as! RepositoryCell
        cell.prepareForReuse()
        cell.configure(object: object)
        
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = viewModel.source[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: MainStoryboard.Segue.toPullRequest, sender: object)
    }
    
    override public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row == (viewModel.source.count - 1) else { return }
        viewModel.triggerInfiniteScrolling()
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.source.count
    }
    
    // Sections
    override public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

