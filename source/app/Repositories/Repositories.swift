//
//  Repositories.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

protocol RepositoriesInterface {

	var sizeList: Int { get }
	var message: String { get }
	func requestItens()
	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell
	func showItem(at index: Int)
	func requestNewDataExpandList()
	func reNewDataResetList()

}

class Repositories: NSObject, RepositoriesInterface {

	var view: RepositoriesViewInterface!
	var router: RouterInterface!
	var sizeList: Int = 0
	var repositories: [Repository] = [Repository]()
	var network = RepositoriesNetwork()
	var page: Int = 1
	var localStorage: LocalDataPersistence = LocalDataPersistence()

	private let messageLoading = "Carregando, aguarde..."
	private let messageError = "Não foi possível consultar os dados, verifique sua conexão com a internet e tente novamente."
	var message: String = ""

	init(view: RepositoriesViewInterface, router: RouterInterface) {
		self.view = view
		self.router = router
		self.view.setTitleView(title: "JavaHub")
	}

// REQUEST ITENS - OPEN APP

	func requestItens() {

		self.message = self.messageLoading
		let localRepositories = requestLocalByNewData(with: self.page == 1 ? "page > 0" : "page > \(self.page)")

		if localRepositories.isEmpty {

			self.requestNetwork { (repositories, error) in

				if error != nil {

					self.message = self.messageError
					self.view.showAlert()

				} else {

					self.finishRequestNewData(repos: repositories!)
				}
			}

		} else {

			self.page = localRepositories.last!.page
			self.updateSizeListReloadView(items: localRepositories)
		}
	}

	func requestNewDataExpandList() {

		self.page = self.repositories.isEmpty ? 1 : self.page +  1
		self.requestNetwork { (newRepos, error) in
			if error != nil {
				self.message = self.messageError
				self.view.showAlert()
				self.page -= 1
			} else {
				self.finishRequestNewData(repos: newRepos!)
			}
		}
	}

	func reNewDataResetList() {

		let cachePage: Int = Int(self.page)
		self.page = 1
		self.requestNetwork { (newRepos, error) in

			if error != nil {

				self.message = self.messageError
				self.view.showAlert()
				self.page = cachePage

			} else {

				self.localStorage.clearLocalStorage()
				self.repositories.removeAll()
				self.finishRequestNewData(repos: newRepos!)
			}
		}
	}

	func finishRequestNewData(repos: [Repository]) {
		repos.forEach({ $0.page = self.page })
		self.localStorage.saveItens(items: repos, reNew: false)
		self.updateSizeListReloadView(items: repos)
	}

	func updateSizeListReloadView(items: [Repository]) {
		self.repositories.append(contentsOf: items)
		self.sizeList = self.repositories.count
		self.view.reloadTableView()
	}

	func requestLocalByNewData(with query: String) -> [Repository] {
		return self.localStorage.list(query: query, entity: Repository.self, property: "stars", isAcendent: false)
	}

	func requestNetwork ( finish: @escaping ([Repository]?, Error?) -> Void ) {
		self.message = self.messageLoading
		self.network.listRepositoriesJavaWith(page: self.page) { (repositories, error) in
			finish(repositories, error)
		}
	}

	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
		if self.sizeList > 0 && !self.repositories.isEmpty{
			cell.setupCell(data: self.repositories[indexPath.row])
		}
		return cell
	}

	func showItem(at index: Int) {
		if self.repositories.count - 1 >= index {
			self.router.goTo(destiny: .pullrequests, pushForward: self.repositories[index])
		}
	}
}
