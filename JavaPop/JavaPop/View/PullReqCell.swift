//
//  PullReqCell.swift
//  JavaPop
//
//  Created by Esdras Emanuel on 24/10/17.
//  Copyright © 2017 evtApps. All rights reserved.
//

import UIKit

class PullReqCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var bodyTxt : UITextView!
    @IBOutlet weak var userPic : UIImageView!
    @IBOutlet weak var userLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bodyTxt.textContainer.lineBreakMode = .byTruncatingTail
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
