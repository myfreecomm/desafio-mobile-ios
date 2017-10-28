//
//  RepositoryTableViewCell.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit

class RepositoryCell : UITableViewCell, UniqueCell {
    
    static var cellIdentifier: String = "repositoryCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksCountLabel: UILabel!
    @IBOutlet weak var starsCountLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    func configure(object: Repository) {
        
        // Repository Data
        nameLabel.text = object.fullName
        descriptionLabel.text = object.objectDescription
        
        // Format value
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."
        formatter.usesGroupingSeparator = true
        
        let forksNumber = NSNumber(value: object.forks)
        let starsNumber = NSNumber(value: object.stars)
        
        forksCountLabel.text = formatter.string(from: forksNumber)
        starsCountLabel.text = formatter.string(from: starsNumber)
        
        // Owner Data
        guard let owner = object.owner else { return }
        userNameLabel.text = owner.name
        userNicknameLabel.text = owner.username
        if  owner.picture != "",
            let url = URL(string: owner.picture),
            let placeholder = UIImage(named: "avatar_noimage") {
            userPicture.sd_setImage(with: url, placeholderImage: placeholder)
        }
    }
}


