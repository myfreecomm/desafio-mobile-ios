//
//  RepositoryTableViewCell.swift
//  nexaas-desafio-ios
//
//  Created by Rogerio Cervasio on 27/10/17.
//  Copyright © 2017 ACME. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageViewPhoto: RoundedImage!
    @IBOutlet weak var labelUsername: UILabel!
    @IBOutlet weak var labelType: UILabel!
    @IBOutlet weak var labelRespositoryName: UILabel!
    @IBOutlet weak var labelRespositoryDescription: UILabel!
    @IBOutlet weak var labelStars: UILabel!
    @IBOutlet weak var labelForks: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageViewPhoto.image = nil
        self.labelUsername.text = nil
        self.labelType.text = nil
        self.labelRespositoryName.text = nil
        self.labelRespositoryDescription.text = nil
        self.labelStars.text = nil
        self.labelForks.text = nil
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
