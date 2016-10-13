//
//  DetailViewController.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RepositorioInfo.h"

@interface DetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (void)getRepoInfos:(RepositorioInfo *) repositorio;

@property(nonatomic, weak) IBOutlet UIButton *btnVoltar;
@property(nonatomic, weak) IBOutlet UITableView *tableView;
@property(nonatomic, weak) IBOutlet UILabel *labelNomeRepositorio;

@end
