//
//  RepositoryViewController.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/18/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class RepsositoryViewController: UITableViewController {

	var detailViewController: PullRequestViewController? = nil
	var repositories: [Repository] = []
	var pagesObtained: UInt = 1
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		Remote.fetchRepositories() {
			(list: [Repository]?) in
			if let res = list {
				self.repositories += res
				self.tableView.reloadData()
			}
		}
		if let split = self.splitViewController {
			split.preferredDisplayMode = .allVisible
			let controllers = split.viewControllers
			self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? PullRequestViewController
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
		super.viewWillAppear(animated)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	// MARK: - Segues
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showDetail" {
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let repository = repositories[indexPath.row]
				let controller = (segue.destination as! UINavigationController).topViewController as! PullRequestViewController
				controller.detailItem = repository
				controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
				controller.navigationItem.leftItemsSupplementBackButton = true
			}
		}
	}
	
	// MARK: - Table View
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryTableViewCell", for: indexPath) as? RepositoryTableViewCell {
		
			let repository = repositories[indexPath.row]
			cell.setUp(fromRepository: repository)
			return cell
		}
		return UITableViewCell()
	}
	
	override func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
		pagesObtained += 1
		Remote.fetchRepositories(fromPage: pagesObtained) {
			(list: [Repository]?) in
			if let res = list {
				self.repositories += res
			}
			self.tableView.reloadData()
		}
	}
}
