//
//  MyCustomTableViewCell.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomTableViewCell : UITableViewCell

@property(nonatomic, weak) IBOutlet UILabel *labelNomeRepositorio;
@property(nonatomic, weak) IBOutlet UILabel *labelDescricaoRepositorio;
@property(nonatomic, weak) IBOutlet UILabel *labelNumberoForks;
@property(nonatomic, weak) IBOutlet UILabel *labelNumberoWatches;
@property(nonatomic, weak) IBOutlet UILabel *labelUsername;
@property(nonatomic, weak) IBOutlet UILabel *labelNomeCompleto;
@property(nonatomic, weak) IBOutlet UIImageView *avatar;

@end
