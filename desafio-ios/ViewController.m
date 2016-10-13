//
//  ViewController.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "MyCustomTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Constants.h"
#import <MTLModel.h>
#import <Mantle.h>
#import "RepositorioInfoJSON.h"
#import "RepositorioInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"
#import "UserInfoUtils.h"

@interface ViewController () {
    NSArray *repositorios;
    NSMutableArray *dataSource;
}

@end

@implementation ViewController

 int pageNumber = 1;
 int pagination = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getJavaPopList:^{
    }];
    
}

- (void)getJavaPopList:(void(^)(void))completion {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlRepositoriosWithPageNumber = URLRepositorios;
    NSString* initialPage = [NSString stringWithFormat:@"%i",pageNumber];
    urlRepositoriosWithPageNumber = [urlRepositoriosWithPageNumber stringByAppendingString:initialPage];
    
    NSURL *URL = [NSURL URLWithString:URLRepositorios];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
        }
        else {
            if (response) {
                NSError *error1;
                NSLog(@"%@", urlRepositoriosWithPageNumber);
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                NSArray *repositoriosInfoJSON = json[@"items"];
                repositorios = [RepositorioInfo deserializeReposInfosFromJSON:repositoriosInfoJSON];
                [_tableView reloadData];
                
                if(completion) {
                    completion();
                }
            }
        }
    }];
    [dataTask resume];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MyCustomTableViewCell";
    MyCustomTableViewCell *cell = (MyCustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyCustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (repositorios != nil) {
        RepositorioInfo *repo = [repositorios objectAtIndex:indexPath.row];
        cell.labelNomeRepositorio.text = [repo nomeRepositorio];
        cell.labelDescricaoRepositorio.text = [repo descricacaoRepositorio];
        cell.labelNumberoForks.text = [[repo numeroForksRepositorio] stringValue];
        cell.labelNumberoWatches.text = [[repo numeroWatchesRepositorio] stringValue];
        cell.labelUsername.text = [repo usernameOwnerRepositorio][@"login"];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString: [repo usernameOwnerRepositorio][@"avatar_url"]]];
        [UserInfoUtils getFullNameOfUserFromPullRequest:[repo usernameOwnerRepositorio][@"login"] completionBlock:^(NSString
        *completion) {
            cell.labelNomeCompleto.text = completion;
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"ShowDetail" sender:tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowDetail"]) {
        DetailViewController *detailViewController = [[DetailViewController alloc]init];
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        RepositorioInfo *repoInfo = [repositorios objectAtIndex:path.row];
        [detailViewController getRepoInfos:repoInfo];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (repositorios != nil) {
        return [repositorios count];
    }
    else {
        return 0;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
