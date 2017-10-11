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

@interface PrincipalTableViewController () {
    NSArray *repositoriesArray;
}

@end

@implementation PrincipalTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.tableView registerClass:[RepositoriesTableViewCell class] forCellReuseIdentifier:@"cell"];
    [[LibraryAPI sharedInstance] getDados];
    [self AtualizarView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)AtualizarView {
    
    NSMutableArray *mut = [NSMutableArray new];
    
    
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    RLMResults<Repository *> *repository = [Repository allObjects];
     
     [realm transactionWithBlock:^{
         for (Repository *repo in repository) {
             [mut addObject:repo];
         }
     }];
    
    
    
    
    /*
    
    Repository *rep = [Repository new];
    rep.name = @"RXJava";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    rep = [Repository new];
    rep.name = @"Java for android";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    rep = [Repository new];
    rep.name = @"Java for linux";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    rep = [Repository new];
    rep.name = @"Java for Windows";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    rep = [Repository new];
    rep.name = @"Java sux";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    rep = [Repository new];
    rep.name = @"Java and the linux";
    rep.repDescription = @"This is a long description for the git repositoty and might have a line break and a truncate tail.";
    rep.forks_count = 999.0;
    rep.stargazers_count = 109.0;
    [mut addObject:rep];
    
    
    
    */
    
    
    
    
    repositoriesArray = [mut copy];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [repositoriesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RepositoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    Repository *repository = repositoriesArray[indexPath.row];
    [cell configureWith:repository];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
