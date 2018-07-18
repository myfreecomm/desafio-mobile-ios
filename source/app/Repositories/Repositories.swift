//
//  Repositories.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

protocol RepositoriesInterface {

}

class Repositories: NSObject, RepositoriesInterface {

	var view: RepositoriesViewInterface!
	var router: RouterInterface!

	init(view: RepositoriesViewInterface, router: RouterInterface) {

		self.view = view
		self.router = router
	}
}
