//
//  PullRequests.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

protocol PullRequestsInterface {
}

class PullRequests: NSObject, PullRequestsInterface{

	var view: PullRequestsViewInterface?

	init(view: PullRequestsViewInterface) {

		self.view = view
	}
}
