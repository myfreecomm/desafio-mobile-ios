//
//  ViewController.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

class ReposViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var viewModel: ReposViewModel!
    
    let cellIdentifier:String = "repoCell"

    var footerView:FooterView?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ReposViewController.handleRefresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ReposViewModel(reloadTableViewCallback: reloadTableViewData)
        
        tableView.addSubview(refreshControl)
        
        footerView = tableView.tableFooterView as? FooterView
        footerView?.footerState = .Spinner
        title = "Java"
   }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - RefreshControl
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        
        viewModel.reposArray = []
        self.footerView?.footerState = .Off
        viewModel.currentPage = 1
        viewModel.retrieveData()
    }
    
    //MARK: - ViewModel Callback
    func reloadTableViewData() {
        switch viewModel.requestStatus {
        case .FetchLimit:
            tableView.tableFooterView = nil
        case .RateLimit:
            footerView?.footerState = .Info
            footerView?.footerLabel.text = "Limite de requisições excedido, tente novamente em alguns segundos."
        case .Other, .Error:
            footerView?.footerState = .Info
            footerView?.footerLabel.text = "Ops!, aconteceu algum problema, tente novamente em alguns segundos."
        default:
            ()
        }
        refreshControl.endRefreshing()
        tableView.reloadData()
    }
            
    // MARK: - TableViewDelegate
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    
        performSegueWithIdentifier("reposToPulls", sender: indexPath)
    }

    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "reposToPulls" {
            let detailViewController = segue.destinationViewController as! PullsViewController
            
            let index = sender as! NSIndexPath
            
            let repo = viewModel.reposArray[index.row]
            
            detailViewController.viewModel = PullsViewModel(reloadTableViewCallback: detailViewController.reloadTableViewData)
            detailViewController.viewModel.repoCreator = repo.repoOwner.ownerName
            detailViewController.viewModel.repoName = repo.repoName
            detailViewController.viewModel.repoIssues = repo.repoIssues
            detailViewController.viewModel.retrieveData()
            detailViewController.title = repo.repoName
        }
        
    }
}

