//
//  PullTableViewCell.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit

class PullTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPhoto: RoundedImage!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelBody: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageViewPhoto.image = nil
        self.labelUsername.text = nil
        self.labelTitle.text = nil
        self.labelDate.text = nil
        self.labelBody.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

