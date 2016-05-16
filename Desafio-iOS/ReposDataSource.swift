//
//  ReposDataSource.swift
//  Desafio-iOS
//
//  Created by Rodrigo Cardoso on 15/05/16.
//  Copyright © 2016 Rodrigo Cardoso. All rights reserved.
//

import UIKit
import SDWebImage

extension ReposViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.reposArray.count
    }
    
    func repoCellForIndexPath(indexPath:NSIndexPath) -> RepoCells {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RepoCells
        
        let repo = viewModel.reposArray[indexPath.row]
        
        cell.repoName.text = repo.repoName
        cell.repoDesc.text = repo.repoDesc
        cell.repoOwnerName.text = repo.repoOwner.ownerName
        cell.repoOwnerFullName.text = repo.repoFullName
        cell.repoForks.text = repo.repoForks != nil ? String(repo.repoForks!) : "0"
        cell.repoStars.text = repo.repoStars != nil ? String(repo.repoStars!) : "0"
        cell.repoOwnerImageView.layer.cornerRadius = cell.repoOwnerImageView.frame.width / 2
        cell.repoOwnerImageView.clipsToBounds = true
        cell.repoOwnerImageView.sd_setImageWithURL(repo.repoOwner.ownerAvatar, placeholderImage: UIImage(named: "man"))
        
        return cell
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if viewModel.reposArray.count - 1 == indexPath.row {
            
            switch viewModel.requestStatus {
            case .RateLimit, .Other:
                viewModel.retrieveData()
                return repoCellForIndexPath(indexPath)
            case .FetchLimit:
                return repoCellForIndexPath(indexPath)
            case .Success:
                viewModel.currentPage += 1
                viewModel.retrieveData()
                return repoCellForIndexPath(indexPath)
            default:
                return repoCellForIndexPath(indexPath)
            }
            
        } else {
            return repoCellForIndexPath(indexPath)
        }
    }

}
