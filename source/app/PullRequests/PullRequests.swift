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
	var message: String { get }
	func requestItens()
	func reNewDataResetList()
	func requestNewDataExpandList()
	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
	func showItem(at index: Int)
}

class PullRequests: NSObject, PullRequestsInterface{

	var view: PullRequestsViewInterface!
	var router: RouterInterface!
	var sizeList: Int = 0
//	var pullrequests: [PullRequest] = [PullRequest]()
	var network = PullRequestNetwork()
	var page: Int = 1
	var repository: Repository!
	var localStorage: LocalDataPersistence = LocalDataPersistence()
	var message: String = ""

	private let messageLoading = "Carregando, aguarde..."
	private let messageError = "Não foi possível consultar os dados, verifique sua conexão com a internet e tente novamente."

	init(view: PullRequestsViewInterface, router: RouterInterface, repository: Repository) {

		self.view = view
		self.router = router
		self.repository = repository
		self.view.setTitleView(title: self.repository.name)
	}

	func requestItens() {

		if self.repository.pullrequests.isEmpty {

			self.requestNetWork { (pullrequests, error) in

				if error != nil {

					self.message = self.messageError
					self.view.showAlert()

				} else {

					self.finishRequestNewData(pulls: pullrequests!)
				}
			}

		} else {

			self.page = self.repository.pullrequests.last!.page
			self.updateSizeListReloadView()
		}
	}

	func requestNewDataExpandList() {

		self.page += 1
		self.requestNetWork { (newPulls, error) in

			if error != nil || newPulls!.isEmpty {

				if newPulls != nil {
					self.message =  "Não há novos itens."
				} else {
					self.message = self.messageError
				}
				self.view.showAlert()
				self.page -= 1

			} else {

				self.finishRequestNewData(pulls: newPulls!)
			}
		}
	}

	func reNewDataResetList() {

		let cachePage: Int = Int(self.page)
		self.page = 1
		self.requestNetWork { (newPulls, error) in

			if error != nil {

				self.message = self.messageError
				self.view.showAlert()
				self.page = cachePage

			} else {

				self.localStorage.updateRepo(newPulls: nil, into: self.repository, clear: true)
				self.finishRequestNewData(pulls: newPulls!)
			}
		}
	}

	func finishRequestNewData(pulls: [PullRequest]) {

		pulls.forEach({ $0.page = self.page })
		self.localStorage.updateRepo(newPulls: pulls, into: self.repository, clear: false)
		self.updateSizeListReloadView()
	}

	func updateSizeListReloadView() {

		self.sizeList = repository.pullrequests.count
		self.view.reloadTableView()
	}

	func requestNetWork ( finish: @escaping ([PullRequest]?, Error?) -> Void ) {

		self.message = self.messageLoading
		self.network.listPullRequestsOf(repoName: repository.name, author: repository.author, page: self.page, completion: { (pullrequests, error) in

			finish(pullrequests, error)
		})
	}

	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: PullRequestCell.identifier, for: indexPath) as! PullRequestCell

		if self.sizeList > 0 && !self.repository.pullrequests.isEmpty{
			cell.setupCell(data: self.repository.pullrequests[indexPath.row])
		}

		return cell
	}

	func showItem(at index: Int) {

		if self.repository.pullrequests.count - 1 >= index {
			self.router.goTo(destiny: .linkBrowser, pushForward: self.repository.pullrequests[index].link)
		}
	}
}
