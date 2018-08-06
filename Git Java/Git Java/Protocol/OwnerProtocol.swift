//
//  OwnerProtocol.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

protocol OwnerProtocol {
    var idOwner: Int { get }
    var login: String { get }
    var avatarUrl: String { get }
}
