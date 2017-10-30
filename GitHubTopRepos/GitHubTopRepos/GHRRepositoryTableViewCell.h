//
//  GHRRepositoryTableViewCell.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRRepositoryTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* repositoryName;
@property (nonatomic, strong) IBOutlet UITextView* repositoryDescription;

@property (nonatomic, strong) IBOutlet UILabel* repositoryForkCounter;
@property (nonatomic, strong) IBOutlet UILabel* repositoryStarCounter;

@property (nonatomic, strong) IBOutlet UIImageView* repositoryOwnerPicture;
@property (nonatomic, strong) IBOutlet UILabel* repositoryOwnerUsername;

-(void)setValuesWithDictionary:(NSDictionary*)dict;

-(void)setNullCell;

@end
