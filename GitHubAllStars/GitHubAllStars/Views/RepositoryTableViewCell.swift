//
//  RepositoryTableViewCell.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 21/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//
import UIKit
import SDWebImage
class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var repositoryTitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var repository: Repository? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let repo = self.repository {
            self.descriptionLabel.text = repo.desc
            self.forksLabel.text = "\(repo.forksCount)"
            self.starsLabel.text = "\(repo.stargazersCount)"
            
            if let owner = repo.owner {
                self.usernameLabel.text = owner.login
                self.nameLabel.text = owner.name
                self.profileImageView.sd_setImage(with: URL(string: owner.avatarURL), placeholderImage: UIImage(named: "github"))
            }
//            self.usernameLabel.text = repo.owner?.login
//            self.nameLabel.text = repo.owner?.name
            self.repositoryTitleLabel.text = repo.name
//            self.profileImageView.sd_setImage(with: URL(string: repo.owner!.avatarURL), placeholderImage: UIImage(named: "github"))
        }
    }
}

