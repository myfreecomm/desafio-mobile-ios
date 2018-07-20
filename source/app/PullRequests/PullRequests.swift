//
//  PullRequests.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

protocol PullRequestsInterface {

	var sizeList: Int { get }
	func requestItens()
	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
	func showItem(at index: Int)
	func incrementPage()
	func resetData()
}

class PullRequests: NSObject, PullRequestsInterface{

	var view: PullRequestsViewInterface!
	var router: RouterInterface!
	var sizeList: Int = 0
	var pullrequests: [PullRequest] = [PullRequest]()
	var network = PullRequestNetwork()
	var page: Int = 1
	var repository: Repository!

	init(view: PullRequestsViewInterface, router: RouterInterface, repository: Repository) {

		self.view = view
		self.router = router
		self.repository = repository
		self.view.setTitleView(title: self.repository.name)
	}

	func requestItens() {
		self.network.listPullRequestsOf(repoName: repository.name, author: repository.author, page: self.page, completion: { (pullrequests) in

			if pullrequests.isEmpty {

				self.page -= 1

			} else {

				self.pullrequests.append(contentsOf: pullrequests)
				self.sizeList = self.pullrequests.count
			}

			self.view.reloadTableView()
		})
	}

	func resetData() {

		self.page = 1
		self.pullrequests.removeAll()
		self.sizeList = self.pullrequests.count
		self.requestItens()
	}

	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.identifier, for: indexPath) as! PullRequestCell

		if self.sizeList > 0 && !self.pullrequests.isEmpty{
			cell.setupCell(data: self.pullrequests[indexPath.row])
		}

		return cell
	}

	func showItem(at index: Int) {

		if self.pullrequests.count - 1 >= index {
			self.router.goTo(destiny: .linkBrowser, pushForward: self.pullrequests[index].link)
		}
	}

	func incrementPage() {
		self.page += 1
	}
}
