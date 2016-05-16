//
//  PullsViewController.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

class PullsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: PullsViewModel!
    
    let cellIdentifier:String = "pullCell"
    
    var headerView:HeaderView?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PullsViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.addSubview(refreshControl)
        
        headerView = tableView.tableHeaderView as? HeaderView
        headerView?.headerState = .Spinner
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - RefreshControl
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        viewModel.pullsArray = []
        viewModel.retrieveData()
    }
    
    //MARK: - ViewModel Callback
    func reloadTableViewData() {
        
        headerView?.headerState = viewModel.headerViewState
        
        switch viewModel.requestStatus {
        case .Success:
            
            headerView?.issuesLabel.text = viewModel.repoIssues != nil ? "\(viewModel.repoIssues!) Issues" : "0 Issues"
            
            headerView?.pullsLabel.text = viewModel.pullsArray.count > 0 ? "\(viewModel.pullsArray.count) Pull Requests" : "0 Pull Requests"
            
        default:
            headerView?.infoLabel.text = viewModel.requestError?.description
        }
        
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
    
    // MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        performSegueWithIdentifier("pullToWeb", sender: indexPath)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "pullToWeb" {
            let detailViewController = segue.destinationViewController as! WebViewController
            let index = sender as! NSIndexPath
            let pullToShow = viewModel.pullsArray[index.row]
            detailViewController.url = pullToShow.pullUrl
            
        }
    }
}
