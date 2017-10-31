//
//  GHRPullRequestsTableViewController.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRPullRequestsTableViewController.h"

#import "GHRPullRequestTableViewCell.h"
#import "GHRGitHubClient.h"

static NSString* _Nonnull cellIdentifier = @"PullRequestCell";

@interface GHRPullRequestsTableViewController ()

@end

@implementation GHRPullRequestsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.openClosedPullRequestsLabel setText:@"Loading..."];
    
    [GHRGitHubClient gitHubPullRequestsFromUser:_owner fromRepository:_repository withCompletionHandler:^(NSArray *list, NSString *error)
    {
        if (error)
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Erro" message:error
                                                                              preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:ok];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            _pullRequestsList = list;
            [self.tableView reloadData];
            
            NSArray* statesArray = [_pullRequestsList valueForKey:@"state"];
            NSIndexSet* indexes = [statesArray indexesOfObjectsPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
            {
                return ([obj isKindOfClass:[NSString class]] && [(NSString*)obj isEqualToString:@"open"]);
            }];
            
            NSUInteger openedPullRequests = indexes.count;
            NSUInteger closedPullRequests = statesArray.count - openedPullRequests;
            
            UIColor* orangeColor = [UIColor colorWithRed:223.0/255 green:147.0/255 blue:4.0/255 alpha:1.0];
            
            NSMutableAttributedString* text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%u opened",openedPullRequests] attributes:@{NSForegroundColorAttributeName: orangeColor}];
            NSMutableAttributedString* text2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" / %u closed",closedPullRequests] attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
            [text appendAttributedString:text2];
            
            [self.openClosedPullRequestsLabel setAttributedText:text];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _pullRequestsList ? _pullRequestsList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHRPullRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item < _pullRequestsList.count)
    {
        [cell setValuesWithDictionary:_pullRequestsList[indexPath.item]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < _pullRequestsList.count)
    {
        NSString* pullUrlPath = [(NSDictionary*)_pullRequestsList[indexPath.item] objectForKey:@"html_url"];
        NSURL* url = [NSURL URLWithString:pullUrlPath];
        
        if (@available(iOS 10.0, *))
        {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
        }
        else
        {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

@end
