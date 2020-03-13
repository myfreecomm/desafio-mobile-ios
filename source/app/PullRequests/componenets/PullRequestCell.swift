//
//  PullRequestCell.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 19/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit

class PullRequestCell: UITableViewCell {

	@IBOutlet weak var name: UILabel!
	@IBOutlet weak var detail: UILabel!
	@IBOutlet weak var photo: UIImageView!
	@IBOutlet weak var ownername: UILabel!
	@IBOutlet weak var date: UILabel!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setupCell(data: PullRequest) {

		self.name.text = data.title
		self.detail.text = data.body
		self.ownername.text = data.author
		self.date.text = "Criado em: \(data.createAt)"

		if data.photo == "" {
			self.photo.image = UIImage(named: "avatar")
		} else {
			self.photo.kf.setImage(with: URL(string: data.photo)!, placeholder: UIImage(named: "avatar"))
		}
	}

	func endDisplay(){

		self.photo.kf.cancelDownloadTask()
	}

	func setupView(){

		self.photo.layer.cornerRadius = self.photo.frame.size.width / 2
		self.photo.clipsToBounds = true
	}
}
