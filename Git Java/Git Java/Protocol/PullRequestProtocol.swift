//
//  PullRequestProtocol.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 29/08/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

protocol PullRequestProtocol {
    var title: String { get }
    var body: String { get }
    var createdAt: String { get }
    var updateAt: String { get }
    var user: OwnerProtocol { get }
}
