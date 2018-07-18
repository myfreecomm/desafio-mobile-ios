//
//  PRTableViewCell.swift
//  ProvaConcrete
//
//  Created by MacBook Pro i7 on 02/08/17.
//  Copyright © 2017 Claudio. All rights reserved.
//

import UIKit

class PRTableViewCell: UITableViewCell {

    @IBOutlet var tituloPR: UILabel!
    @IBOutlet var dataPR: UILabel!
    @IBOutlet var bodyPR: UILabel!
    @IBOutlet var nomeAutorPR: UILabel!
    @IBOutlet var fotoAutorPR: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

