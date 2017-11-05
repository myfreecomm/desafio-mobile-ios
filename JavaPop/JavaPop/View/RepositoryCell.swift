//
//  RepositoryCell.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 23/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var forksLbl : UILabel!
    @IBOutlet weak var starsLbl : UILabel!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var userLbl : UILabel!
    @IBOutlet weak var userNameLbl : UILabel!
    @IBOutlet weak var descTxt : UITextView!
    @IBOutlet weak var userImg : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        forksLbl.setFAText(prefixText: "", icon: .FACodeFork, postfixText: "562", size: 17)
        forksLbl.setFAColor(color: UIColor.orange)
        
        starsLbl.setFAText(prefixText: "", icon: .FAStar, postfixText: "48", size: 17)
        starsLbl.setFAColor(color: UIColor.orange)
        
        self.descTxt.textContainer.lineBreakMode = .byTruncatingTail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func setForks(value : Int){
        forksLbl.setFAText(prefixText: "", icon: .FACodeFork, postfixText: "\(value)", size: 17)
        forksLbl.setFAColor(color: UIColor.orange)
    }
    
    func setStars(value : Int){
        starsLbl.setFAText(prefixText: "", icon: .FAStar, postfixText: "\(value)", size: 17)
        starsLbl.setFAColor(color: UIColor.orange)
    }
    
}
