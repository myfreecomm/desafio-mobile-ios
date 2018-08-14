//
//  PullRequestViewController.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/18/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit

class PullRequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet var pullRequestTableView: UITableView!
	var pullRequests: [PullRequest] = []
	
	func configureView() {
		// Update the user interface for the detail item.
		if detailItem != nil, let name = detailItem?.repositoryFullName {
			Remote.retrievePullRequests(fromRepositoryNamed: name) { (list: [PullRequest]?) in
				if let res = list {
					self.pullRequests = res
					self.pullRequestTableView.reloadData()
					if res.count == 0 {
						self.alertMessage(message: "Este repositório não possui Pull Requests abertos")
					}
				} else {
					self.alertMessage(message: "Houve um problema ao carregar a lista. Por favor, tente novamente")
				}
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.pullRequestTableView.tableFooterView = UIView(frame: CGRect.zero)
		self.pullRequestTableView.backgroundColor = UIColor.clear
		self.navigationItem.title = detailItem?.name
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.configureView()
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	var detailItem: Repository? {
		didSet {
			// Update the view.
			self.configureView()
		}
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return pullRequests.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if let cell = tableView.dequeueReusableCell(withIdentifier: "PullRequestTableViewCell", for: indexPath) as? PullRequestTableViewCell {
		
			let pullRequest = pullRequests[indexPath.row]
			cell.setUp(fromPullRequest: pullRequest)
			return cell
		}
		return UITableViewCell()
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
		UIApplication.shared.openURL(pullRequests[indexPath.row].prURL)
	}
	
	func alertMessage (message: String) {
		let alert = UIAlertController(title: "Pull Requests", message: message, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
