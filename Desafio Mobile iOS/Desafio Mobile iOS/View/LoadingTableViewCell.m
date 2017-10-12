//
//  LoadingTableViewCell.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 12/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "LoadingTableViewCell.h"

@implementation LoadingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initUIElements];
    }
    
    return self;
}


-(void)initUIElements {
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    self.activityIndicatorView = [UIActivityIndicatorView new];
    self.activityIndicatorView.frame = CGRectMake(0, 0, 30, 30);
    self.activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [self.activityIndicatorView setColor:[UIColor grayColor]];
    [self.activityIndicatorView startAnimating];
    [self addSubview:self.activityIndicatorView];
}


-(void)layoutSubviews {
    self.activityIndicatorView.center = self.contentView.center;
    [self.activityIndicatorView setHidden:NO];
}


@end
