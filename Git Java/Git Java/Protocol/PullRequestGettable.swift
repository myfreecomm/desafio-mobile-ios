//
//  PullRequestGettable.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

protocol  PullRequestGettable {
    func getPullRequest(owner:String, repository:String, completion: (([PullRequest]) -> Void)?)
}
