//
//  DataPersistence.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 21/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

//typealias Objects = [Object]

class LocalDataPersistence {

	private let systemEnviroment = EnviromentIdentifier()
	private let realm = try! Realm()

	func saveItens(items: [Object], reNew: Bool) {

		try!  realm.write {
			realm.add(items, update: reNew)
		}
	}

	func clearLocalStorage() {
		try! realm.write {
			realm.deleteAll()
		}
	}

	func list<T: Object>(query: String?, entity: T.Type, property: String, isAcendent: Bool) -> [T] {

		var result = realm.objects(entity)

		if query != nil {

			result = result.filter(query!)
		}

		return Array(result.sorted(byKeyPath: property, ascending: isAcendent))
	}
}
