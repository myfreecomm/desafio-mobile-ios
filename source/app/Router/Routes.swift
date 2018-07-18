//
//  Routes.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

enum Routes {

	case repositories
	case pullrequest

	var file: String{

		switch self {

		case .repositories:
			return "RepositoriesView"
		case .pullrequest:
			return "PullRequestView"
		}
	}
}
