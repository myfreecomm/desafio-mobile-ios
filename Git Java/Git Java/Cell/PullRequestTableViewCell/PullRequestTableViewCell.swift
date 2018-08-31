//
//  PullRequestTableViewCell.swift
//  Git Java
//
//  Created by Filipe Amaral Neis on 29/08/2018.
//  Copyright © 2018 Neis. All rights reserved.
//

import UIKit
import Kingfisher

class PullRequestTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var avatarUserImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var updateAtLabel: UILabel!
    
    func setupCell(pullRequest: PullRequest) {
        
        let viewModel = PullRequestViewModel(pullRequest: pullRequest)
        self.titleLabel.text = viewModel.title
        self.bodyLabel.text = viewModel.body
        self.createdAtLabel.text = String(format: "%@%@" , "Criado: " ,viewModel.createdAt)
        self.updateAtLabel.text = String(format: "%@%@" , "Atualizado: " ,viewModel.updateAt)
        self.userNameLabel.text = viewModel.user.login
        self.avatarUserImageView.kf.setImage(with: URL(string: viewModel.user.avatarUrl))
        self.avatarUserImageView.round()
        
    }
    
    
}
