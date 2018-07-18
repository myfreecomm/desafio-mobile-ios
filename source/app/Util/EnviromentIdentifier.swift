//
//  EnviromentIdentifier.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 17/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation

struct EnviromentIdentifier {

	var  enviroment: String {

		guard let enviromentString = Bundle.main.infoDictionary?["ENVIRONMENT"] as? String else {
			return ""
		}

		return enviromentString
	}
}
