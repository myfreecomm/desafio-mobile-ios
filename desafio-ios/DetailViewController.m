//
//  DetailViewController.m
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import "DetailViewController.h"
#import "MyDetailTableViewCell.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Constants.h"
#import <MTLModel.h>
#import <Mantle.h>
#import "PullRequestInfoJSON.h"
#import "PullRequestInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UserInfoUtils.h"

@interface DetailViewController () {
    NSArray *pullRequests;
}

@end

static RepositorioInfo *repoInfo;

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _labelNomeRepositorio.text = [repoInfo nomeRepositorio];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *urlWithParameters = URLPullRequests;
    urlWithParameters = [urlWithParameters stringByAppendingString:[repoInfo usernameOwnerRepositorio][@"login"]];
    urlWithParameters = [urlWithParameters stringByAppendingString:@"/"];
    urlWithParameters = [urlWithParameters stringByAppendingString:[repoInfo nomeRepositorio]];
    urlWithParameters = [urlWithParameters stringByAppendingString:@"/pulls"];
    
    NSURL *URL = [NSURL URLWithString:urlWithParameters];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    __block NSArray *pullRequestsInfoJSON;
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            
        }
        else {
            if (response) {
                NSError *error1;
                pullRequestsInfoJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
                pullRequests = [PullRequestInfo deserializePullRequestsInfosFromJSON:pullRequestsInfoJSON];
                [_tableView reloadData];
            }
        }
    }];
    [dataTask resume];
}

- (void)getRepoInfos:(RepositorioInfo *) repositorio {
    repoInfo = repositorio;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MyDetailTableViewCell";
    MyDetailTableViewCell *cell = (MyDetailTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MyDetailTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    if (pullRequests != nil) {
        PullRequestInfo *pullRequest = [pullRequests objectAtIndex:indexPath.row];
        cell.labelNomePullRequest.text = [pullRequest nomePullRequest];
        cell.labelDescricaoPullRequest.text = [pullRequest descricacaoPullRequest];
        cell.labelUsername.text = [pullRequest usernamePullRequest][@"login"];
        [cell.avatar sd_setImageWithURL:[NSURL URLWithString: [pullRequest usernamePullRequest][@"avatar_url"]]];
        [UserInfoUtils getFullNameOfUserFromPullRequest:[pullRequest usernamePullRequest][@"login"] completionBlock:^(NSString *completion) {
                cell.labelNomeCompleto.text = completion;
        }];
    }
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (repoInfo != nil) {
        return [pullRequests count];
    }
    else {
        return 10;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)btnVoltarClicked:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
