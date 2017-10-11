//
//  RepositoriesTableViewCell.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 11/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repository.h"

@interface RepositoriesTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *nomeRepositorioLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *nomeSobrenomeLabel;
@property (strong, nonatomic) IBOutlet UIImageView *starImageView;
@property (strong, nonatomic) IBOutlet UIImageView *forkImageView;
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutlet UILabel *forkCountLabel;
@property (strong, nonatomic) IBOutlet UILabel *starCountLabel;

-(void)configureWith:(Repository *)repository;

@end
