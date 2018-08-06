//
//  RepositoryTableViewCell.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 25/07/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit
import Kingfisher

class RepositoryTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var avatarNameLabel: UILabel!
    @IBOutlet weak var iconForkLabel: UILabel!
    @IBOutlet weak var forkValueLabel: UILabel!
    @IBOutlet weak var iconStarLabel: UILabel!
    @IBOutlet weak var starValueLabel: UILabel!
    
    func setupCell(repository: Repository) {
        
        let viewModel = RepositoryViewModel(repository: repository)
        nameLabel.text = viewModel.name
        descriptionLabel.text = viewModel.description
        avatarNameLabel.text = viewModel.owner.login
        avatarImageView.kf.setImage(with: URL(string: viewModel.owner.avatarUrl))
        avatarImageView.round()
        
        iconForkLabel.text =  "\u{126}"
        iconStarLabel.text = "\u{2605}"
        starValueLabel.text = String(format: "%i", viewModel.starCount)
        forkValueLabel.text = String(format: "%i", viewModel.forkCount)
    }
}
