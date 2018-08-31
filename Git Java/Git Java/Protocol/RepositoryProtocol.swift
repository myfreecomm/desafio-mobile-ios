//
//  RepositoryProtocol.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    var idRepository: Int { get             }
    var name: String { get }
    var description: String { get }
    var forkCount: Int { get }
    var starCount: Int { get }
    var owner: OwnerProtocol { get }
}

