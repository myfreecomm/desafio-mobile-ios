//
//  PullRequestTableViewController.h
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 12/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repository.h"

@interface PullRequestTableViewController : UITableViewController

- (void)setRepository:(Repository *) repo;

@end
