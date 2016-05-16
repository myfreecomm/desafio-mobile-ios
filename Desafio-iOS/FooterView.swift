//
//  FooterView.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

enum FooterViewState:Int {
    case Off = 0, Spinner = 1, Info = 2
}

class FooterView: UIView {
    
    @IBOutlet weak var pagingSpinner: UIActivityIndicatorView!
    @IBOutlet weak var footerLabel: UILabel!
    
    var footerState:FooterViewState = .Spinner {
        willSet {
            if newValue == .Spinner {
                footerLabel.hidden = true
                pagingSpinner.startAnimating()
            } else if newValue == .Info {
                footerLabel.hidden = false
                pagingSpinner.stopAnimating()
            } else {
                footerLabel.hidden = true
                pagingSpinner.stopAnimating()
            }
        }
    }
    
    
    
}
