//
//  RepositoryTableViewCellCollectionViewCell.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import SDWebImage

class RepositoryTableViewCell: UITableViewCell {
	@IBOutlet weak var repositoryName: UILabel!
	@IBOutlet weak var repositoryDescription: UILabel!
	@IBOutlet weak var numberOfStars: UILabel!
	@IBOutlet weak var numberOfForks: UILabel!
	@IBOutlet weak var ownerLogin: UILabel!
	@IBOutlet weak var ownerAvatar: UIImageView!
	@IBOutlet weak var ownerName: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func setUp(fromRepository repository: Repository) {
		repositoryName.text = repository.name
		repositoryDescription.text = repository.description
		numberOfStars.text = String(repository.numberOfStars)
		numberOfForks.text = String(repository.numberOfForks)
		ownerLogin.text = repository.owner.login
		ownerAvatar.sd_setImage(with: repository.owner.avatarUrl, placeholderImage: #imageLiteral(resourceName: "user"))
		guard repository.owner.userName != nil else {
			ownerName.text = "Carregando..."
			return
		}
		ownerName.text = repository.owner.userName
	}
}
