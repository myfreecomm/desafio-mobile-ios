//
//  RepositoryViewModel.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

class RepositoryViewModel: RepositoryProtocol {
   
    private var repository: Repository = Repository()
    
    init(repository: Repository) {
        self.repository = repository
    }
    var idRepository: Int {
        return repository.idRepository ?? 0
    }
    
    var name: String {
        return repository.name ?? ""
    }
    
    var description: String {
        return repository.description ?? ""
    }
    
    var forkCount: Int {
        return repository.forkCount ?? 0
    }
    
    var starCount: Int {
        return repository.starCount ?? 0
    }
    
    var owner: OwnerProtocol {
        guard let owner = repository.owner else {
            return  OwnerViewModel(owner: Owner(idOwner: nil, login: nil, avatarUrl: nil))
        }
        return OwnerViewModel(owner: owner)
    }
}
