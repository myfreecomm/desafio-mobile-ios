//
//  SharedProtocols.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SVProgressHUD

public protocol UniqueCell {
    static var cellIdentifier : String { get set }
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
