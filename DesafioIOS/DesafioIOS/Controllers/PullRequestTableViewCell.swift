//
//  PullRequestTableViewCell.swift
//  DesafioIOS
//
//  Created by Felipe Ricieri on 28/10/17.
//  Copyright © 2017 Nexaas. All rights reserved.
//

import UIKit
import SDWebImage

/**
 *  PullRequestTableViewCell
 *  @description    Pull Request's table cell
 */
class PullRequestTableViewCell : UITableViewCell, UniqueCell {
    
    /**
     * Cell identifier
     */
    static var cellIdentifier: String = "pullRequestCell"
    
    /**
     * Outlets
     */
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPicture: UIImageView!
    
    /**
     *  configure(object:)
     *  @description    Configures cell with given data
     *  @param object   Pull Request object
     */
    func configure(object: PullRequest) {
        
        // Repository Data
        nameLabel.text = object.title
        descriptionLabel.text = object.objectDescription
        
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

