//
//  MyCustomTableViewCell.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "MyCustomTableViewCell.h"

@implementation MyCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _avatar.layer.backgroundColor=[[UIColor clearColor] CGColor];
    _avatar.layer.cornerRadius = 25;
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.borderColor = [[UIColor clearColor] CGColor];
}

@end
