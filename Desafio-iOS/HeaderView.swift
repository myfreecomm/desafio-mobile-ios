//
//  HeaderView.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

enum HeaderViewState:Int {
    case Default = 0, Spinner = 1, Info = 2
}

class HeaderView: UIView {

    @IBOutlet weak var pullsLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var issuesLabel: UILabel!
    @IBOutlet weak var pagingSpinner: UIActivityIndicatorView!
    
    var headerState:HeaderViewState = .Spinner {
        willSet {
            if newValue == .Spinner {
                pullsLabel.hidden = true
                infoLabel.hidden = true
                issuesLabel.hidden = true
                pagingSpinner.startAnimating()
                
            } else if newValue == .Info {
                pullsLabel.hidden = true
                infoLabel.hidden = false
                issuesLabel.hidden = true
                pagingSpinner.stopAnimating()
            } else {
                pullsLabel.hidden = false
                infoLabel.hidden = true
                issuesLabel.hidden = false
                pagingSpinner.stopAnimating()
            }
        }
    }

}
