//
//  SharedProtocols.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import Foundation
import SVProgressHUD

/**
 *  UniqueCell Protocol
 *  @description    Every cell representation must have its own unique identifier
 */
public protocol UniqueCell {
    static var cellIdentifier : String { get set }
}

/**
 *  Hud Protocol
 *  @description    Easy way to show/hide huds
 */
public protocol Hud { }
public extension Hud {
    
    /**
     *  showHud()
     *  @description    Shows hud in screen
     */
    func showHud() {
        DispatchQueue.main.async {
            SVProgressHUD.show()
        }
    }
    
    /**
     *  errorHud()
     *  @description    Shows error hud in screen
     */
    func errorHud(_ errorString: String) {
        DispatchQueue.main.async {
            SVProgressHUD.showError(withStatus: errorString)
        }
    }
    
    /**
     *  hideHud()
     *  @description    Dismiss the presented hud
     */
    func hideHud() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
