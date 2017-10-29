//
//  DropShadowNavigationBar.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

/**
 *  DropShadowNavigationBar
 *  @description    Custom Navigation bar with slight drop shadow
 */
class DropShadowNavigationBar : UINavigationBar {
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        let shadowPath = CGRect(
            x: self.layer.bounds.origin.x - 10,
            y: self.layer.bounds.size.height - 6,
            width: self.layer.bounds.size.width + 20,
            height: 5
        )
        
        self.layer.shadowPath = UIBezierPath(rect: shadowPath).cgPath
        self.layer.shouldRasterize = true
    }
}

