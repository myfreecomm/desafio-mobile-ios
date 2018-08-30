//
//  PullRequestViewController.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 29/08/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit

class PullRequestViewController: UIViewController {
    
    //MARK: - Properties
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    var pullRequests: [PullRequest] = []
    var repositoryViewModel:RepositoryViewModel!
    //MARK: Outlet
    @IBOutlet weak var tableview: UITableView!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = repositoryViewModel.name
        setupTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        let service = PullRequestService()
        service.getPullRequest(owner: repositoryViewModel.owner.login, repository: repositoryViewModel.name) { [weak self] (pullRequests) in
            
            self?.pullRequests = pullRequests
            self?.tableview.reloadData()
            self?.activityIndicator.removeFromSuperview()
            if pullRequests.isEmpty {
                self?.tableEmpty()
            }
        }
    }
    
    //MARK: - Setup
    func setupTableView() {
        
        self.tableview.delegate = self
        self.tableview.dataSource = self
        let nib = UINib(nibName: "PullRequestTableViewCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "cell")
        self.tableview.tableFooterView = UIView()
        self.tableview.estimatedRowHeight = 90
    }
    
    //MARK: Create
    static func create(repos:RepositoryViewModel) -> PullRequestViewController {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "PullRequestViewController") as! PullRequestViewController
        viewController.repositoryViewModel = repos
        return viewController
    }
    
    //MARK: Methods
     func tableEmpty(){
        
        let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: self.tableview.bounds.size.width, height: self.tableview.bounds.size.height))
        noDataLabel.text          = "Nenhum pull request feito."
        noDataLabel.textColor     = UIColor.black
        noDataLabel.textAlignment = .center
        self.tableview.backgroundView  = noDataLabel
        self.tableview.separatorStyle  = .none
        
    }
}
//MARK: - Table View Delegate
extension PullRequestViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
//MARK: - Table View Data Source
extension PullRequestViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pullRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PullRequestTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(pullRequest: pullRequests[indexPath.row])
        return cell
    }
    
    
}
