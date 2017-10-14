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
    UIActivityIndicatorView *activityIndicatorView;
}

@end

static Repository *repository;

@implementation PullRequestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = repository.name;
    [self AtualizarView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AtualizarView) name:kStrNotificationPullRequestFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificarPullRequestError:) name:kStrNotificationPullRequestError object:nil];
    
    activityIndicatorView = [UIActivityIndicatorView new];
    activityIndicatorView.frame = CGRectMake(0, 0, 20, 20);
    activityIndicatorView.center = self.tableView.center;
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [activityIndicatorView startAnimating];
    [self.tableView addSubview:activityIndicatorView];
    
    [[LibraryAPI sharedInstance] getPullRequestsfromRepository:repository];
}


- (void)setRepository:(Repository *) repo {
    repository = repo;
}


-(void)notificarPullRequestError:(NSNotification *)notification {
    NSString *mensagem = notification.userInfo[@"mensagem"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha ao atualizar" message:mensagem delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [activityIndicatorView stopAnimating];
    [activityIndicatorView setHidden:YES];
}


-(void)AtualizarView {
    [activityIndicatorView stopAnimating];
    [activityIndicatorView setHidden:YES];
    
    NSMutableArray *pullRequestsMutableArray = [NSMutableArray new];
    pullRequestsArray = [NSArray new];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
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


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ([pullRequestsArray count] > 0) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30)];
        [view setBackgroundColor:[UIColor whiteColor]];
        
        int openedCount = 0;
        int closedCount = 0;
        
        for (PullRequest *pullRequest in pullRequestsArray) {
            if ([pullRequest.state isEqualToString:@"open"]) {
                openedCount++;
            } else if ([pullRequest.state isEqualToString:@"closed"]) {
                closedCount++;
            }
        }
        
        UILabel *openedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width / 2, view.frame.size.height)];
        openedLabel.textColor = [UIColor orangeColor];
        openedLabel.font = [UIFont boldSystemFontOfSize:13];
        openedLabel.textAlignment = NSTextAlignmentRight;
        openedLabel.text = [NSString stringWithFormat:@"%i opened", openedCount];
        [view addSubview:openedLabel];
        
        UILabel *closedLabel = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.size.width / 2, 0, view.frame.size.width / 2, view.frame.size.height)];
        closedLabel.textColor = [UIColor blackColor];
        closedLabel.font = [UIFont boldSystemFontOfSize:13];
        closedLabel.text = [NSString stringWithFormat:@"/ %i closed", closedCount];
        [view addSubview:closedLabel];
        
        return view;
    } else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PullRequest *pullRequest = pullRequestsArray[indexPath.row];
    
    NSURL *url = [NSURL URLWithString:pullRequest.url];
    [[UIApplication sharedApplication] openURL:url];
}

@end
