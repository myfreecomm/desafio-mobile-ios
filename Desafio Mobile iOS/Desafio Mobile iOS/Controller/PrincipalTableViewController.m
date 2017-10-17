//
//  PrincipalTableViewController.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PrincipalTableViewController.h"
#import "LibraryAPI.h"
#import "Constantes.h"
#import "RepositoriesTableViewCell.h"
#import "LoadingTableViewCell.h"
#import "PullRequestTableViewController.h"

@interface PrincipalTableViewController () {
    UIActivityIndicatorView *activityIndicatorView;
    NSArray *repositoriesArray;
    int page;
}

@end

@implementation PrincipalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.tableView registerClass:[LoadingTableViewCell class] forCellReuseIdentifier:@"loadingCell"];
    
    [self AtualizarView];
    
    activityIndicatorView = [UIActivityIndicatorView new];
    activityIndicatorView.frame = CGRectMake(0, 0, 20, 20);
    activityIndicatorView.center = self.tableView.center;
    activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    activityIndicatorView.color = [UIColor grayColor];
    [activityIndicatorView startAnimating];
    [self.tableView addSubview:activityIndicatorView];
    
    page = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AtualizarView) name:kStrNotificationRepositoriesFinished object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificarRepositoriesError:) name:kStrNotificationRepositoriesError object:nil];
    [[LibraryAPI sharedInstance] getRepositories:page];
    
}

-(void)notificarRepositoriesError:(NSNotification *)notification {
    NSString *mensagem = notification.userInfo[@"mensagem"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Falha ao atualizar" message:mensagem delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    
    [activityIndicatorView stopAnimating];
    [activityIndicatorView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AtualizarView {
    [activityIndicatorView stopAnimating];
    [activityIndicatorView setHidden:YES];
    
    NSMutableArray *repositoriesMutableArray = [NSMutableArray new];
    
    repositoriesArray = [NSArray new];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults<Repository *> *repository = [Repository allObjects];
     
     [realm transactionWithBlock:^{
         for (Repository *repo in repository) {
             [repositoriesMutableArray addObject:repo];
         }
     }];
    
    repositoriesArray = [repositoriesMutableArray copy];
    [self.tableView reloadData];
}

//#pragma mark - Notifications

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([repositoriesArray count] > 0) {
        return [repositoriesArray count] + 1;
    } else {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL lastItemReached = indexPath.row >= [repositoriesArray count];
    
    if ((lastItemReached) && [repositoriesArray count] > 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadingCell" forIndexPath:indexPath];
        page++;
        [[LibraryAPI sharedInstance] getRepositories:page];
        return cell;
    } else {
        if ([repositoriesArray count] > 0) {
            RepositoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.textLabel.text = @"";
            Repository *repository = repositoriesArray[indexPath.row];
            
            if (repository) {
                [cell configureWith:repository];
            } else {
                NSLog(@"Não achou o item no repositório???");
            }
            
            return cell;
        } else {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kSeguePullRequests]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Repository *repository = repositoriesArray[indexPath.row];
        
        if (repository.pulls_url) {
            PullRequestTableViewController *destinationViewController = [[PullRequestTableViewController alloc] init];
            [destinationViewController setRepository:repository];
        }
    }
}


@end
