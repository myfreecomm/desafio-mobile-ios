//
//  PullRequestViewModel.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 29/08/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

class PullRequestViewModel: PullRequestProtocol {
    
    private var pullRequest: PullRequest = PullRequest()
    
    init(pullRequest: PullRequest) {
        self.pullRequest = pullRequest
    }
    
    var title: String {
        return pullRequest.title ?? ""
    }
    
    var body: String {
      return pullRequest.body ?? ""
    }
    
    var createdAt: String {
        return pullRequest.createdAt?.formatDatePtBr() ?? "-"
    }
    
    var updateAt: String {
        return pullRequest.updateAt?.formatDatePtBr() ?? "-"
    }
    
    
    var user: OwnerProtocol {
        guard let owner = pullRequest.user else {
            return  OwnerViewModel(owner: Owner(idOwner: nil, login: nil, avatarUrl: nil))
        }
        return OwnerViewModel(owner: owner)
    }
    
    
}
