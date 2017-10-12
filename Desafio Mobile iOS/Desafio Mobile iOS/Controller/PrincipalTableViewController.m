//
//  PrincipalTableViewController.m
//  Desafio Mobile iOS
//
//  Created by Adriano Rezena on 10/10/17.
//  Copyright © 2017 Adriano Rezena. All rights reserved.
//

#import "PrincipalTableViewController.h"
#import "LibraryAPI.h"
#import "RepositoriesTableViewCell.h"
#import "LoadingTableViewCell.h"

@interface PrincipalTableViewController () {
    NSArray *repositoriesArray;
    int page;
}

@end

@implementation PrincipalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[LoadingTableViewCell class] forCellReuseIdentifier:@"loadingCell"];
    page = 1;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AtualizarView) name:kStrNotificationRepositoriesFinished object:nil];
    [[LibraryAPI sharedInstance] getDados:page];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AtualizarView {
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
    
    //NSLog(@"indexPath.row = %i ||||| [repositoriesArray count] = %i", indexPath.row, [repositoriesArray count]);
    
    if ((lastItemReached) && [repositoriesArray count] > 0) {
        NSLog(@"lastItemReached");
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"loadingCell" forIndexPath:indexPath];
        page++;
        [[LibraryAPI sharedInstance] getDados:page];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
