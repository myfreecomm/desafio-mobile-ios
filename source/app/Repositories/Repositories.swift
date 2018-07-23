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
	func incrementPage()
	func resetData()
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

	func requestItens(){

		self.message = self.messageLoading
		let localRepositories = requestLocalByNewData(with: self.page == 1 ? "page > 0" : "page > \(self.page)")

		if localRepositories.isEmpty {

			self.requestNetworkByNewData()

		} else {

			self.repositories.append(contentsOf: localRepositories)
			self.finishGetItems()
			self.page = self.repositories.last!.page
		}
	}

	func requestLocalByNewData(with query: String) -> [Repository]{

		return self.localStorage.list(query: query, entity: Repository.self, property: "stars", isAcendent: false)
	}

	func requestNetworkByNewData() {

		self.message = self.messageLoading

		self.network.listRepositoriesJavaWith(page: self.page) { (repositories, error) in

			if error != nil {

				self.message = self.messageError
				self.page -= 1
				if !self.repositories.isEmpty {
					self.page = self.repositories.last!.page
					self.sizeList = self.repositories.count
				}
				self.view.disableLoading()
				self.view.showAlert()

			} else {

				if self.page == 1 {
					self.localStorage.clearLocalStorage()
					self.repositories.removeAll()
					self.sizeList = 0
				}

				repositories!.forEach{ $0.page = self.page }
				self.repositories.append(contentsOf: repositories!)
				self.localStorage.saveItens(items: repositories!, reNew: false)
				self.finishGetItems()
			}
		}
	}

	func finishGetItems() {

		self.sizeList = self.repositories.count
		self.view.reloadTableView()
	}

	func resetData() {

		self.page = 1
		self.requestNetworkByNewData()
	}

	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell{

		let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell

		if self.sizeList > 0 && !self.repositories.isEmpty{
			cell.setupCell(data: self.repositories[indexPath.row])
		}

		return cell
	}

	func showItem(at index: Int){

		if self.repositories.count - 1 >= index {
			self.router.goTo(destiny: .pullrequests, pushForward: self.repositories[index])
		}
	}

	func incrementPage() {

		self.page += 1
	}
}
