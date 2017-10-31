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

-(void)setValuesWithPullRequest:(GHRPullRequest*)pull
{
    self.pullRequestName.text = pull.name;
    self.pullRequestDescription.text = pull.pullRequestDescription;
    
    self.pullRequestDate.text = pull.creationDate;
    self.pullRequestOwnerUsername.text = pull.ownerUsername;
    
    @synchronized(_noPictureUser)
    {
        if (!_noPictureUser) _noPictureUser = [UIImage imageNamed:@"undefined_user"];
        self.pullRequestOwnerPicture.image = _noPictureUser;
    }
    
    [GHRGitHubClient githubUserPictureFromUrlPath:pull.ownerPictureUrlPath withCompletionHandler:^(UIImage *picture, NSString *error)
    {
        if (!error) self.pullRequestOwnerPicture.image = picture;
    }];
}

@end
