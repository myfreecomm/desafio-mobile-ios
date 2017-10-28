//
//  SharedProtocols.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SVProgressHUD

public protocol Parameterizable {
    func toDictionary() -> [AnyHashable : Any]
}

public protocol Hud { }
public extension Hud {
    func showHud() {
        SVProgressHUD.show()
    }
    func errorHud(_ errorString: String) {
        SVProgressHUD.showError(withStatus: errorString)
    }
    func hideHud() {
        SVProgressHUD.dismiss()
    }
}
