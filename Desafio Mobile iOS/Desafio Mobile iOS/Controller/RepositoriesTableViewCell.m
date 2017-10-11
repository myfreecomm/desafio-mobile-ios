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
    self.starCountLabel.text = [NSString stringWithFormat:@"%i", repository.stargazers_count];
    self.forkCountLabel.text = [NSString stringWithFormat:@"%i", repository.forks_count];
    self.usernameLabel.text = @"adriano.rezena";
    self.nomeSobrenomeLabel.text = @"Adriano Rezena";
}

@end
