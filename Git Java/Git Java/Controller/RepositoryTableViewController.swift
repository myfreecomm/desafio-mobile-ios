//
//  RepositoryTableViewController.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit

class RepositoryTableViewController: UITableViewController {
    
    //MARK: - Properties
    var repositories: [Repository] = []
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    let service = RepositoryService()
    var totalPage: Int = 0
    var page: Int = 1
    var refresher: UIRefreshControl!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        startActivityIndicator()
        getRepositories(isRefresher: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - Setup
    func setupTableView() {
        let attributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.refresher = UIRefreshControl()
        self.refresher.attributedTitle = NSAttributedString(string: "Atualizando", attributes: attributes)
        self.refresher.tintColor = .white
        self.refresher?.addTarget(self, action: #selector(self.refresh(sender:)), for: UIControlEvents.valueChanged)
        let nib = UINib(nibName: "RepositoryTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        self.tableView?.addSubview(refresher!)
       // self.tableView.backgroundColor = UIColor.backgroundInvolves
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = 90
    }
    
    func startActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
    }
    
    //MARK: - Methods
    @objc func refresh(sender: AnyObject) {
        self.repositories = []
        self.page = 1
        self.getRepositories(isRefresher: true)
    }
    
    func getRepositories(isRefresher: Bool) {
        service.getRepository(page: page) { repositories, totalPage  in
            self.totalPage = totalPage
            self.repositories = repositories
            self.tableView.reloadData()
            if isRefresher {
                self.refresher.endRefreshing()
            } else {
                self.activityIndicator.removeFromSuperview()
            }
        }
    }
    
    func pagination() {
        self.page += 1
        if self.page <= self.totalPage {
            service.getRepository(page: page, completion: { repositories, totalPage in
                self.totalPage = totalPage
               self.repositories.append(contentsOf: repositories)
                self.tableView.reloadData()
                if repositories.isEmpty {
                    self.tableView?.tableFooterView?.isHidden = true
                }
            })
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.setupCell(repository: repositories[indexPath.row])
        return cell
    }
    
    override open func tableView(_ tableView: UITableView,
                                 willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == repositories.count - 5 {
            pagination()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let service = PullRequestService()
        let repos = self.repositories[indexPath.row]
        service.getPullRequest(owner: (repos.owner?.login!)!, repository: repos.name!) { (pullRequests) in
            print(pullRequests)
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
