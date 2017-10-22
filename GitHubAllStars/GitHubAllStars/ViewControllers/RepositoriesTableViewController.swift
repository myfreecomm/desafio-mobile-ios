//
//  RepositoriesTableViewController.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit

class RepositoriesTableViewController: UITableViewController {
    var repositories = [Repository]()
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburger"), style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        
        let nib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier:
            "RepositoryTableViewCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        
        self.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadData() {
        DataManager.sharedInstance.getStarsRepositories(language: "Java", page: 1) { (error, message, repositoriesResponse) in
            if(!error) {
                if let repositories = repositoriesResponse {
                    if(self.page > 1 && repositories.count > 0) {
                        self.repositories.removeAll()
                    }
                    self.repositories.append(contentsOf: repositories)
                    self.tableView.reloadData()
                }
            }
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
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let repository = self.repositories[indexPath.row]
        self.performSegue(withIdentifier: "prSegue", sender: repository)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
