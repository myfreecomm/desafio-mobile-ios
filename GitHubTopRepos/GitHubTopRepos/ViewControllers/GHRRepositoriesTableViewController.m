//
//  GHRRepositoriesTableViewController.m
//  GitHubTopRepos
//
//  Created by Vitor Marques de Miranda on 30/10/2017.
//  Copyright © 2017 Vitor Marques de Miranda. All rights reserved.
//

#import "GHRRepositoriesTableViewController.h"

#import "GHRPullRequestsTableViewController.h"
#import "GHRRepositoryTableViewCell.h"
#import "GHRGitHubClient.h"
#import "GHRRepository.h"

#import "NSMutableArray+Extension.h"

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
            return;
        }
        
        NSMutableArray* mutableList = [list mutableCopy];
        [mutableList replaceObjectsWithVariation:^id(id object, NSUInteger index)
        {
            return [GHRRepository repositoryWithDictionary:object];
        }];
        _repositoriesList = mutableList;
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    GHRPullRequestsTableViewController* destination = [segue destinationViewController];
    destination.owner      = [(GHRRepository*)sender ownerUsername];
    destination.repository = [(GHRRepository*)sender name];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _repositoriesList ? _repositoriesList.count : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GHRRepositoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (indexPath.item < _repositoriesList.count)
    {
        [cell setValuesWithRepository:_repositoriesList[indexPath.item]];
    }
    else
    {
        [cell setNullCell];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < _repositoriesList.count)
    {
        [self performSegueWithIdentifier:segueIdentifier sender:_repositoriesList[indexPath.item]];
    }
}

@end
