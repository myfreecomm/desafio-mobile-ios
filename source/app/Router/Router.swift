//
//  Router.swift
//  javahubTests
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

protocol RouterInterface {

	func goTo(destiny: Routes, pushForward data: Any?)
}

class Router: NSObject, RouterInterface {

	weak var view: RouterViewInterface?

	init(view: RouterViewInterface) {
		super.init()

		self.view = view
	}

	func goTo(destiny: Routes, pushForward data: Any?) {

		switch destiny {

		case .repositories:

			let viewInstance = buildView(destiny.file, RepositoriesViewController.identifier, RepositoriesViewController.self)

			viewInstance.presenter = Repositories(view: viewInstance, router: self)
			self.view?.setViewControllers([viewInstance], animated: false)

		case .pullrequests:

			let viewInstance = buildView(destiny.file, PullRequestsViewController.identifier, PullRequestsViewController.self)

			viewInstance.presenter = PullRequests(view: viewInstance)
			self.view?.pushViewController(viewInstance, animated: true)

		}
	}

	func buildView<T>(_ nameFile: String, _ identifier: String, _ viewClass: T.Type) -> T{

		return UIStoryboard(name: nameFile, bundle: nil).instantiateViewController(withIdentifier: identifier) as! T
	}
}
