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

	init(view: RepositoriesViewInterface, router: RouterInterface) {

		self.view = view
		self.router = router
	}

	func requestItens(){

		self.network.listRepositoriesJavaWith(page: self.page) { (repositories) in

			self.repositories.append(contentsOf: repositories)
			self.sizeList = self.repositories.count
			self.view.reloadTableView()
		}
	}

	func resetData() {

		self.page = 1
		self.sizeList = self.repositories.count
		self.repositories.removeAll()
		self.requestItens()
	}

	func buildCell(to tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell{

		let cell = UITableViewCell()

		if self.sizeList > 0 {
			cell.textLabel?.text = self.repositories[indexPath.row].name
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
