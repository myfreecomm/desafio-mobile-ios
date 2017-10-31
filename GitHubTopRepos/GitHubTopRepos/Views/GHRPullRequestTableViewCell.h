//
//  GHRPullRequestTableViewCell.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRPullRequestTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel* pullRequestName;
@property (nonatomic, strong) IBOutlet UITextView* pullRequestDescription;

@property (nonatomic, strong) IBOutlet UIImageView* pullRequestOwnerPicture;
@property (nonatomic, strong) IBOutlet UILabel* pullRequestOwnerUsername;

@property (nonatomic, strong) IBOutlet UILabel* pullRequestDate;

-(void)setValuesWithDictionary:(NSDictionary*)dict;

@end
