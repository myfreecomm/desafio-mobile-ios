//
//  AppDelegate+LaunchNavigation.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

extension AppDelegate{

	func launchNavtigation(){

		let navController = RouterView.sharedInstance
		navController.presenter = Router(view: navController)

		navController.presenter?.goTo(destiny: .repositories, pushForward: nil)

		navController.navigationBar.isTranslucent = false

		self.window =  UIWindow(frame: UIScreen.main.bounds)

		self.window?.rootViewController = navController
		self.window?.makeKeyAndVisible()
	}
}
