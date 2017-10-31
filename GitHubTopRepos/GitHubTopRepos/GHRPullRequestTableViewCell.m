//
//  GHRPullRequestTableViewCell.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRPullRequestTableViewCell.h"

#import "GHRGitHubClient.h"

static UIImage* _noPictureUser;

@implementation GHRPullRequestTableViewCell

-(void)setValuesWithDictionary:(NSDictionary*)dict
{
    self.pullRequestName.text = dict[@"title"];
    self.pullRequestDescription.text = [dict[@"body"] isKindOfClass:[NSString class]] ? dict[@"body"] : @"";
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    NSDate* date = [formatter dateFromString:dict[@"created_at"]];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    self.pullRequestDate.text = [formatter stringFromDate:date];
    
    self.pullRequestOwnerUsername.text = dict[@"user"][@"login"];
    
    @synchronized(_noPictureUser)
    {
        if (!_noPictureUser) _noPictureUser = [UIImage imageNamed:@"undefined_user"];
        self.pullRequestOwnerPicture.image = _noPictureUser;
    }
    
    [GHRGitHubClient githubUserPictureFromUrlPath:dict[@"user"][@"avatar_url"] withCompletionHandler:^(UIImage *picture, NSString *error)
     {
         if (!error) self.pullRequestOwnerPicture.image = picture;
     }];
}

@end
