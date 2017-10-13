//
//  PullRequestTableViewController.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 12/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PullRequestTableViewController.h"
#import "PullRequestTableViewCell.h"
#import "LibraryAPI.h"

@interface PullRequestTableViewController () {
    NSArray *pullRequestsArray;
}

@end

static Repository *repository;

@implementation PullRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = repository.name;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AtualizarView) name:kStrNotificationPullRequestFinished object:nil];
    [[LibraryAPI sharedInstance] getPullRequestsfromRepository:repository];
}


- (void)setRepository:(Repository *) repo {
    repository = repo;
}


-(void)AtualizarView {
    NSMutableArray *pullRequestsMutableArray = [NSMutableArray new];
    pullRequestsArray = [NSArray new];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    //RLMResults<PullRequest *> *pullRequests = [PullRequest allObjects];
    RLMResults<PullRequest *> *pullRequests = [PullRequest objectsWhere:@"repositoryId = %i", repository.id];
    
    [realm transactionWithBlock:^{
        for (PullRequest *pull in pullRequests) {
            [pullRequestsMutableArray addObject:pull];
        }
    }];
    
    pullRequestsArray = [pullRequestsMutableArray copy];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [pullRequestsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PullRequestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pullRequestCell" forIndexPath:indexPath];
    
    PullRequest *pullRequest = pullRequestsArray[indexPath.row];
    [cell configureWith:pullRequest];

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PullRequest *pullRequest = pullRequestsArray[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:pullRequest.url];
    
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:NULL];
    }else{
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
