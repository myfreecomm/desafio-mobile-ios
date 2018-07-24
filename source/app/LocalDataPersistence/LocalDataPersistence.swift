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

class LocalDataPersistence: NSObject {

	private let realm = try! Realm()

	func saveItens(items: [Object], reNew: Bool) {

		try!  realm.write {
			realm.add(items, update: reNew)
		}
	}

	func updateRepo(newPulls: [PullRequest]?, into repo: Repository, clear: Bool){

		if clear {

			try!  realm.write {
				realm.delete(repo.pullrequests)
			}

		} else {

			try!  realm.write {
				repo.pullrequests.append(objectsIn: newPulls!)
				realm.add(repo, update: true)
			}
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
