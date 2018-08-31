//
//  ExtensionString.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 29/08/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import Foundation

extension String {
    
    func formatDatePtBr() -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let date = formatter.date(from: self)
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: date!)
    }
}
