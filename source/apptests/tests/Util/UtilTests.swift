//
//  UtilTests.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 20/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Quick
import Nimble
@testable import javahub

class UtilTests: QuickSpec {

	override func spec() {
		
        describe("Test Util") {

			context("NSObject+Identifier", closure: {

				it ("Test extension NSObject+Identifier", closure:{

					expect(NSObject.identifier).to(equal("NSObject"))
				})

				it("Test struct EnviromentIdentifier", closure:{

					let env = EnviromentIdentifier()

					expect(env.enviroment).to(equal("debug"))

				})
            })

			context("UITableViewController+MessageTableView", closure: {

				var tableViewController: UITableViewController!
				beforeEach {

					tableViewController = UITableViewController()
					tableViewController.tableView = UITableView()
				}

				it("Test extension UITableViewController+MessageTableView: Empty tableView", closure:{

					let rows: Int = tableViewController.showMessageTableEmpty(text: "Test Message", amount: 0, tableView: tableViewController.tableView)
					let label: UILabel = tableViewController.tableView.backgroundView as! UILabel

					expect(rows).to(equal(0))
					expect(label.text).to(equal("Test Message"))
					expect(tableViewController.tableView.separatorStyle).to(equal(UITableViewCellSeparatorStyle.none))

				})

				it("Test extension UITableViewController+MessageTableView: Not Empty tableView", closure:{

					let tableViewController = UITableViewController()
					tableViewController.tableView = UITableView()

					let rows: Int = tableViewController.showMessageTableEmpty(text: "Test Message", amount: 1, tableView: tableViewController.tableView)

					expect(rows).to(equal(1))
					expect(tableViewController.tableView.backgroundView).toNot(beAnInstanceOf(UILabel.self))
					expect(tableViewController.tableView.separatorStyle).to(equal(UITableViewCellSeparatorStyle.singleLine))

				})
			})

			context("AppDelegate+LaunchNavigation", closure: {

				var appDelegate: AppDelegate!

				beforeEach {

					appDelegate = AppDelegate()

				}

				it("LaunchNavigation", closure:{

					appDelegate.launchNavtigation()

					expect(appDelegate.window?.rootViewController).toEventually(beAnInstanceOf(RouterView.self))
				})
			})
        }
	}
}
