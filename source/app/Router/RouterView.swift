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
}

class RouterView: UINavigationController, RouterViewInterface {

	static let sharedInstance = RouterView()
	var presenter: RouterInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
	}
}
