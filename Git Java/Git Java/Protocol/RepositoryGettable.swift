//
//  RepositoryGettable.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

protocol  RepositoryGettable {
    func getRepository(page:Int, completion: (([Repository], Int) -> Void)?)
}
