//
//  RepositoryTableViewCell.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

class RepositoryCell : UITableViewCell {
    
    static let objectID = "repositoryCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    func configure(object: Repository) {
        
        // Repository Data
        self.nameLabel.text = object.fullName
        self.descriptionLabel.text = object.objectDescription
        
        // Format value
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        let forksNumber = NSNumber(value: object.forks)
        let starsNumber = NSNumber(value: object.stars)
        self.forksCountLabel.text = formatter.string(from: forksNumber)
        self.starsCountLabel.text = formatter.string(from: starsNumber)
        
        // Owner Data
        if  let owner = object.owner {
            self.userNameLabel.text = owner.name
            self.userNicknameLabel.text = owner.username
            if  owner.picture != "",
                let url = URL(string: owner.picture),
                let placeholder = UIImage(named: "avatar_noimage") {
                self.userPicture.sd_setImage(with: url, placeholderImage: placeholder)
                // Image Configuration
                self.userPicture.layer.cornerRadius = 20
            }
        }
    }
}


