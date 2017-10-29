//
//  Foundation+Extensions.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation

extension NotificationCenter {
    // Notification Names
    struct Name {
        static let Reachable = Notification.Name("nc_reachable")
        static let NotReachable = Notification.Name("nc_notReachanle")
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

