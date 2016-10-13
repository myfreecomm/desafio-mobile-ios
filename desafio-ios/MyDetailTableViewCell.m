//
//  MyDetailTableViewCell.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "MyDetailTableViewCell.h"

@implementation MyDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _avatar.layer.backgroundColor=[[UIColor clearColor] CGColor];
    _avatar.layer.cornerRadius = 25;
    _avatar.layer.masksToBounds = YES;
    _avatar.layer.borderColor = [[UIColor clearColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
