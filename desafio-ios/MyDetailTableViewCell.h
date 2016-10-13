//
//  MyDetailTableViewCell.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDetailTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *labelNomePullRequest;
@property(nonatomic, weak) IBOutlet UILabel *labelDescricaoPullRequest;
@property(nonatomic, weak) IBOutlet UILabel *labelUsername;
@property(nonatomic, weak) IBOutlet UILabel *labelNomeCompleto;
@property(nonatomic, weak) IBOutlet UIImageView *avatar;

@end
