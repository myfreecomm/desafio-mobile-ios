//
//  ReposTableViewCell.swift
//  ProvaConcrete
//
//  Created by MacBook Pro i7 on 02/08/17.
//  Copyright © 2017 Claudio. All rights reserved.
//

import UIKit

class ReposTableViewCell: UITableViewCell {
    @IBOutlet var nomeRepos: UILabel!
    @IBOutlet var descrRepos: UILabel!
    @IBOutlet var numeroForks: UILabel!
    @IBOutlet var numeroEstrelas: UILabel!
    @IBOutlet var fotoAutor: UIImageView!
    @IBOutlet var nomeAutor: UILabel!
    @IBOutlet var nomeUsuario: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
