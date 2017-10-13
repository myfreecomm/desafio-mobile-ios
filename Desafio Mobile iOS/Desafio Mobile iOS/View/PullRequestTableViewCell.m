//
//  PullRequestTableViewCell.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 12/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PullRequestTableViewCell.h"

@implementation PullRequestTableViewCell

-(void)configureWith:(PullRequest *)pullRequest {
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.clipsToBounds = YES;
    
    self.titleLabel.text = pullRequest.title;
    self.bodyLabel.text = pullRequest.body;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    
    self.created_atLabel.text = [dateFormatter stringFromDate:pullRequest.created_at];
    
    if (pullRequest.owner) {
        self.usernameLabel.text = pullRequest.owner.login;
        [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString: pullRequest.owner.avatar_url]];
        self.nomeSobrenomeLabel.text = pullRequest.owner.name;
    }
}

@end
