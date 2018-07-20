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
		self.updateData()
		self.setBackButtonTitle(with: "")
    }

	func requestNewData(){

		self.presenter.incrementPage()
		self.presenter.requestItens()
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

	@objc func updateData(){

		self.presenter.resetData()
		self.tableView.reloadData()
	}

	func reloadTableView() {

		self.tableView.reloadData()
		self.refreshControl!.endRefreshing()
		self.tableView.finishInfiniteScroll()
	}

	func setupTableView(){

		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 220
		self.tableView.tableFooterView = UIView()
	}

	func registerCell() {
		// Add custom cell register to tableview here
		self.tableView.register(UINib(nibName: PullRequestCell.identifier, bundle: nil), forCellReuseIdentifier: PullRequestCell.identifier)
	}

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.showMessageTableEmpty(text: "Carregando, aguarde...", amount: self.presenter!.sizeList, tableView: self.tableView)
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
