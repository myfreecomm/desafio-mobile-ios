//
//  StarView.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

class StarView: UIView {

    override func drawRect(rect: CGRect)
    {
        Drawings.drawStar(frame: rect, withColor: UIColor(red: 0.839, green: 0.686, blue: 0.349, alpha: 1))
    }
}
