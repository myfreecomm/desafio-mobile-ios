//
//  GHRRepositoryTableViewCell.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRRepositoryTableViewCell.h"

#import "GHRGitHubClient.h"

static UIImage* _noPictureUser;

@implementation GHRRepositoryTableViewCell

-(void)setValuesWithRepository:(GHRRepository*)repo
{
    self.repositoryName.text = repo.name;
    self.repositoryDescription.text = repo.repositoryDescription;
    
    self.repositoryForkCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)repo.forkCounter];
    self.repositoryStarCounter.text = [NSString stringWithFormat:@"%lu",(unsigned long)repo.starCounter];
    
    self.repositoryOwnerUsername.text = repo.ownerUsername;
    
    @synchronized(_noPictureUser)
    {
        if (!_noPictureUser) _noPictureUser = [UIImage imageNamed:@"undefined_user"];
        self.repositoryOwnerPicture.image = _noPictureUser;
    }
    
    [GHRGitHubClient githubUserPictureFromUrlPath:repo.ownerPictureUrlPath withCompletionHandler:^(UIImage *picture, NSString *error)
    {
        if (!error) self.repositoryOwnerPicture.image = picture;
    }];
}

-(void)setNullCell
{
    self.repositoryName.text = @"Loading...";
    self.repositoryDescription.text = @"";
    
    self.repositoryForkCounter.text = @"";
    self.repositoryStarCounter.text = @"";
    
    self.repositoryOwnerUsername.text = @"";
    self.repositoryOwnerPicture.image = nil;
}

@end
