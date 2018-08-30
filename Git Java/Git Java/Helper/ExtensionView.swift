//
//  Extension.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 27/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit

extension UIView {

    func round() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
