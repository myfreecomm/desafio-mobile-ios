//
//  RepositoriesTableViewCell.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "RepositoriesTableViewCell.h"

@implementation RepositoriesTableViewCell

-(void)configureWith:(Repository *)repository {
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width / 2;
    self.avatarImageView.clipsToBounds = YES;
    
    self.nomeRepositorioLabel.text = repository.name;
    self.descriptionLabel.text = repository.repDescription;
    self.starCountLabel.text = [NSString stringWithFormat:@"%i", (int)repository.stargazers_count];
    self.forkCountLabel.text = [NSString stringWithFormat:@"%i", (int)repository.forks_count];
                                
    if (repository.owner) {
        self.usernameLabel.text = repository.owner.login;
        
        if (repository.owner.avatar_url) {
            [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString: repository.owner.avatar_url]];
            self.avatarImageView.backgroundColor = [UIColor clearColor];
        } else {
            self.avatarImageView.image = [UIImage imageNamed:@"avatar.png"];
            self.avatarImageView.backgroundColor = [UIColor grayColor];
        }

        self.nomeSobrenomeLabel.text = repository.owner.name;
    }
}

@end
