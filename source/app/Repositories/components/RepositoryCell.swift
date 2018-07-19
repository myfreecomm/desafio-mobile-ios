//
//  RepositoryCell.swift
//  javahub
//
//  Created by Tiago da Silva Amaral on 19/07/18.
//  Copyright © 2018 com.outlook.tiagofly. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftIconFont
class RepositoryCell: UITableViewCell {

	@IBOutlet private weak var name: UILabel!
	@IBOutlet private weak var photo: UIImageView!
	@IBOutlet private weak var ownername: UILabel!
	@IBOutlet private weak var detail: UILabel!
	@IBOutlet private weak var forks: UILabel!
	@IBOutlet private weak var starts: UILabel!

	private var index: Int!

	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

		self.setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	func setupCell(data: Repository, at index: Int) {

		self.name.text = data.name
		self.detail.text = data.detail
		self.ownername.text = data.author
		self.photo.kf.setImage(with: URL(string: data.photo)!, placeholder: UIImage(named: "avatar"))
		self.buildIconText(label: self.forks, fontSize: 16.0, text: String(data.forks), fontName: "codefork")
		self.buildIconText(label: self.starts, fontSize: 16.0, text: String(data.stars), fontName: "star")

		self.index = index
	}

	func endDisplay(){

		self.photo.kf.cancelDownloadTask()
	}

	func setupView(){

		self.photo.layer.cornerRadius = self.photo.frame.size.width / 2
		self.photo.clipsToBounds = true
	}

	func buildIconText(label: UILabel, fontSize: CGFloat, text: String, fontName: String){

		label.font = UIFont.icon(from: .fontAwesome, ofSize: fontSize)

		var finalStartsString = String()
		let icon = String.fontAwesomeIcon(fontName)!

		finalStartsString.append(icon)
		finalStartsString.append(" ")
		finalStartsString.append(text)

		label.text = finalStartsString

	}
}
