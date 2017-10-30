//
//  GHRRepositoryTableViewCell.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRRepositoryTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel* repositoryName;
@property (nonatomic, strong) UITextView* repositoryDescription;

@property (nonatomic, strong) UILabel* repositoryForkCounter;
@property (nonatomic, strong) UILabel* repositoryStarCounter;

@property (nonatomic, strong) UIImageView* repositoryOwnerPicture;
@property (nonatomic, strong) UILabel* repositoryOwnerUsername;

@end
