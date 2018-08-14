//
//  PullRequestTableViewCell.swift
//  desafioIOS
//
//  Created by Vagner Oliveira on 7/19/17.
//  Copyright © 2017 Vagner Oliveira. All rights reserved.
//

import UIKit
import SDWebImage

class PullRequestTableViewCell: UITableViewCell {
	
	@IBOutlet var title: UILabel!
	@IBOutlet var prDate: UILabel!
	@IBOutlet var prBody: UILabel!
	@IBOutlet var ownerLogin: UILabel!
	@IBOutlet var ownerAvatar: UIImageView!
	@IBOutlet weak var ownerName: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	func setUp(fromPullRequest pullRequest: PullRequest) {
		title.text = pullRequest.title
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
		prDate.text = formatter.string(from: pullRequest.prDate)
		prBody.text = pullRequest.prBody
		ownerLogin.text = pullRequest.owner.login
		ownerAvatar.sd_setImage(with: pullRequest.owner.avatarUrl, placeholderImage: #imageLiteral(resourceName: "user"))
		guard pullRequest.owner.userName != nil else {
			ownerName.text = "Carregando..."
			return
		}
		ownerName.text = pullRequest.owner.userName
	}
}
