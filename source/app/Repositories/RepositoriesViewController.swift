//
//  RepositoriesView.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

protocol RepositoriesViewInterface {

	func reloadTableView()
	func setTitleView(title: String)
	func showAlert()
	func disableLoading()
}

class RepositoriesViewController: UITableViewController, RepositoriesViewInterface {

	var presenter: RepositoriesInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 220
        self.clearsSelectionOnViewWillAppear = false
		self.registerCell()
		self.setupInfinityScroll()
		self.setupRefreshControl()
//		self.updateData()

		self.presenter!.requestItens()
		self.setBackButtonTitle(with: "")
    }

	// Request new data to append in tableview and increment current page. Used by INFINITY SCROLL
	func requestNewData() {

		self.presenter!.incrementPage()
		self.presenter!.requestItens()
	}

	// Reset page to 1, clear data from local, and request. Used by PULL REQUEST
	@objc func updateData(){

		self.presenter!.resetData()
		self.tableView.reloadData()
	}

	func setTitleView(title: String) {
		self.navigationItem.title = title
	}

	func setupRefreshControl(){

		self.refreshControl = UIRefreshControl()
		self.refreshControl!.addTarget(target, action: #selector(updateData), for: .valueChanged)
	}

	func setupInfinityScroll () {

		self.tableView.infiniteScrollIndicatorStyle  = .gray
		self.tableView.infiniteScrollIndicatorMargin = 40
		self.tableView.infiniteScrollTriggerOffset   = 500

		self.tableView.addInfiniteScroll { (tableView) in

			self.requestNewData()
		}
	}

	func reloadTableView() {

		self.tableView.reloadData()

		self.disableLoading()
	}

	func disableLoading(){

		self.refreshControl!.endRefreshing()
		self.tableView.finishInfiniteScroll()
	}

	func showAlert() {

		let alert = UIAlertController(title: "Alert", message: self.presenter!.message, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
	}

	func registerCell() {
		// Add custom cell register to tableview here
		self.tableView.register(UINib(nibName: RepositoryCell.identifier, bundle: nil), forCellReuseIdentifier: RepositoryCell.identifier)
	}

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

		return self.showMessageTableEmpty(text: self.presenter!.message, amount: self.presenter!.sizeList, tableView: self.tableView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		return self.presenter!.buildCell(to: self.tableView, at: indexPath)
	}

	override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

		(cell as! RepositoryCell).endDisplay()
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		self.presenter!.showItem(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
