//
//  UITableViewController+MessageTableView.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 18/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

extension UITableViewController {

	func showMessageTableEmpty(text: String, amount: Int, tableView: UITableView ) -> Int{

		let message = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))

		if amount == 0 {

			message.isHidden = false
			message.textAlignment = .center
			message.numberOfLines = 0
			message.textColor = .gray
			message.font = UIFont(name: "Consolas", size: 18)
			message.text = text
			message.sizeToFit()

			tableView.backgroundView = message
			tableView.separatorStyle = .none

			return 0

		} else {

			tableView.backgroundView = UIView()
			tableView.separatorStyle = .singleLine

			return amount
		}
	}
}
