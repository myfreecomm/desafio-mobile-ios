//
//  GHRRepositoriesTableViewController.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRRepositoriesTableViewController.h"

#import "GHRGitHubClient.h"

static NSString* _Nonnull cellIdentifier = @"RepositoryCell";

static NSString* _Nonnull segueIdentifier = @"PullRequestsSegue";

@implementation GHRRepositoriesTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GHRGitHubClient gitHubTopRepositories:^(NSArray *list, NSString *error)
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
            _repositoriesList = list;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _repositoriesList ? _repositoriesList.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:segueIdentifier sender:_repositoriesList[indexPath.item]];
}

@end
