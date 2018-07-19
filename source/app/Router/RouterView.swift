//
//  RouterView.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

protocol RouterViewInterface: class{

	func setViewControllers(_: [UIViewController], animated: Bool)
	func pushViewController(_: UIViewController, animated: Bool)
}

class RouterView: UINavigationController, RouterViewInterface {

	static let sharedInstance = RouterView()
	var presenter: RouterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setStyles()
	}

	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	func setStyles(){

		self.navigationBar.barTintColor = UIColor(red: 46.0/255.0, green: 40.0/255.0, blue: 42.0/255.0, alpha: 1.0)
		self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
		self.navigationBar.tintColor = .white
	}
}
