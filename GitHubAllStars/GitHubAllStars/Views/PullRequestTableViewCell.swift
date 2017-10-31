//
//  PullRequestTableViewCell.swift
//  GitHubAllStars
//
//  Created by Raphael Araújo on 23/10/17.
//  Copyright © 2017 Raphael Araújo. All rights reserved.
//

import UIKit
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var pullRequestTitleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var pullRequest: PullRequest? {
        didSet {
            layoutSubviews()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let pr = self.pullRequest {
            self.pullRequestTitleLabel.text = pr.title
            self.descriptionLabel.text = pr.body
            
            if let user = pr.user {
                self.usernameLabel.text = user.login
                self.nameLabel.text = user.name
                self.profileImageView.sd_setImage(with: URL(string: user.avatarURL), placeholderImage: UIImage(named: "github"))
            }
            
            let dateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ", locale: "pt-BR")
            if let date = dateFormatter.date(from: pr.created_at) {
                dateFormatter.dateFormat = "dd/MM/yyyy"
                self.dateLabel.text = dateFormatter.string(from: date)
            } else {
                self.dateLabel.text = ""
            }
        }
    }
    
}
