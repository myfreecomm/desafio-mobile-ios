//
//  GHRPullRequestsTableViewController.h
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GHRPullRequestsTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView* tableView;
@property (nonatomic, weak) IBOutlet UILabel* openClosedPullRequestsLabel;

@property (nonatomic, strong) NSString* owner;
@property (nonatomic, strong) NSString* repository;

@property (nonatomic, strong) NSArray* pullRequestsList;

@end
