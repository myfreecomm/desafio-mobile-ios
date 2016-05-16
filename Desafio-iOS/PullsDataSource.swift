//
//  PullsDataSource.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit

extension PullsViewController: UITableViewDataSource {
        
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.pullsArray.count
    }
    
    func pullCellForIndexPath(indexPath:NSIndexPath) -> PullCells {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! PullCells
        
        let pull = viewModel.pullsArray[indexPath.row]
        
        cell.pullTitle.text = pull.pullTitle
        cell.pullBody.text = pull.pullBody.isEmpty ? "No Info Available." : pull.pullBody
        cell.pullAuthorName.text = pull.pullUser.userName
        cell.pullAuthorImageView.layer.cornerRadius = cell.pullAuthorImageView.frame.width / 2
        cell.pullAuthorImageView.clipsToBounds = true
        cell.pullAuthorImageView.sd_setImageWithURL(pull.pullUser.userAvatar, placeholderImage: UIImage(named: "man"))
        cell.pullDate.text = NSDateFormatter.localizedStringFromDate(pull.pullDate!, dateStyle: NSDateFormatterStyle.LongStyle, timeStyle: NSDateFormatterStyle.NoStyle)
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        return pullCellForIndexPath(indexPath)
    }
}