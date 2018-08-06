//
//  OwnerViewModel.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

class OwnerViewModel: OwnerProtocol {
    
    private var owner: Owner = Owner()
    
    init(owner: Owner) {
        self.owner = owner
    }
    
    var idOwner: Int {
        return owner.idOwner ?? 0
    }
    
    var login: String {
        return owner.login ?? ""
    }
    
    var avatarUrl: String {
        return owner.avatarUrl ?? ""
    }
    
    
}
