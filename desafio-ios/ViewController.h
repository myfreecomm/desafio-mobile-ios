//
//  ViewController.h
//  desafio-ios
//
//  Copyright © 2016 Samuel Catalano. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (void)getJavaPopList:(void(^)(void))completion;

@property(nonatomic, weak) IBOutlet UITableView *tableView;

@end
