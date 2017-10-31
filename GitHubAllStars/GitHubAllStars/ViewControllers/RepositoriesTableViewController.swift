//
//  RepositoriesTableViewController.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import Alamofire
class RepositoriesTableViewController: UITableViewController {
    var repositories = [Repository]()
    var page = 1
    var isLoadingData = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let nib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier:
            "RepositoryTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.tableFooterView = UIView()
        self.refreshControl?.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        self.refreshControl?.tintColor = .gray
        self.tableView.addSubview(self.refreshControl!)
        self.loadData()
    }
    
    @objc func handleRefresh(_: UIRefreshControl) {
        self.page = 1
        loadData()
    }
    
    func loadData() {
        DataManager.sharedInstance.getStarsRepositories(language: "Java", page: self.page) { (error, message, repositoriesResponse) in
            if !error {
                if let repositories = repositoriesResponse {
                    if(repositories.count > 0) {
                        if(self.page > 1) {
                            self.repositories.append(contentsOf: repositories)
                        } else {
                            self.repositories = repositories
                        }
                        self.tableView.reloadData()
                        self.page += 1
                    } else {
                        if(self.repositories.count == 0) {
                            print("Nenhum respositório encontrado")
                        } else {
                            self.page = -1
                        }
                    }
                }
            }
            self.isLoadingData = false
            self.refreshControl?.endRefreshing()
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as! RepositoryTableViewCell
        cell.repository = self.repositories[indexPath.row]
        if NetworkReachabilityManager()!.isReachable {
            if(indexPath.row == self.repositories.count - 1 && self.page != 0 && !self.isLoadingData) {
                self.loadData()
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let repository = self.repositories[indexPath.row]
        self.performSegue(withIdentifier: "prSegue", sender: repository)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "prSegue" {
            if let prVC = segue.destination as? PullRequestTableViewController {
                prVC.repository = sender as? Repository
            }
        }
    }
}
