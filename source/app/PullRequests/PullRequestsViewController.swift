//
//  PullRequestsViewController.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit
import UIScrollView_InfiniteScroll

protocol PullRequestsViewInterface {

	func showAlert()
	func reloadTableView()
	func setTitleView(title: String)
}

class PullRequestsViewController: UITableViewController, PullRequestsViewInterface {

	var presenter: PullRequestsInterface!

    override func viewDidLoad() {
        super.viewDidLoad()

		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 220
		self.tableView.tableFooterView = UIView()

		self.setupTableView()
		self.registerCell()
		self.setupInfinityScroll()
		self.setupRefreshControl()
		self.setBackButtonTitle(with: "")

		self.presenter!.requestItens()
    }

	@objc func updateData(){

		self.presenter!.reNewDataResetList()
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

			self.presenter!.requestNewDataExpandList()
		}
	}

	func reloadTableView() {

		self.tableView.reloadData()
		self.disableLoading()
	}

	func setupTableView(){

		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 220
		self.tableView.tableFooterView = UIView()
	}

	func disableLoading(){

		self.refreshControl!.endRefreshing()
		self.tableView.finishInfiniteScroll()
	}

	func showAlert() {

		let alert = UIAlertController(title: "Alert", message: self.presenter!.message, preferredStyle: UIAlertControllerStyle.alert)
		alert.addAction(UIAlertAction(title: "Fechar", style: .default, handler: { _ in

			self.disableLoading()
		}))
		self.present(alert, animated: true, completion: nil)
	}

	func registerCell() {
		self.tableView.register(UINib(nibName: PullRequestCell.identifier, bundle: nil), forCellReuseIdentifier: PullRequestCell.identifier)
	}

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showMessageTableEmpty(text: self.presenter!.message, amount: self.presenter!.sizeList, tableView: self.tableView)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.presenter.buildCell(to: tableView, at: indexPath) as! PullRequestCell
    }

	override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		(cell as! PullRequestCell).endDisplay()
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.presenter.showItem(at: indexPath.row)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
