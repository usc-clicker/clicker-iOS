//
//  MXProfileViewController.m
//  clicker
//
//  Created by Michael on 11/5/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "MXProfileViewController.h"
#import "JLClickerUserManager.h"
#import "JLAPIManager.h"

@interface MXProfileViewController ()
@property (nonatomic, strong) NSArray * stats;
@end

@implementation MXProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getUserStats];
    
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

-(void)getUserStats {
    [JLAPIManager getStatsWithUsername:[JLClickerUserManager user]
                      andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                          self.stats = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                          NSLog(@"stats; %@", self.stats);
#warning assuming it works
                          
//                          if (dictionary[kErrorKey]) {
//                              [self getStatsFailedWithError:(dictionary[kErrorKey])];
//                          }
//                          else {
                              [self getStatsSuccess];
//                          }
                      }];
}


-(void)getStatsSuccess {
    [self.statsTableView reloadData];
}

-(void)getStatsFailedWithError:(NSError *) error {
    
}

- (IBAction)logoutButtonAction:(id)sender {
    [JLClickerUserManager setLoggedOut];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stats.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"statsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", self.stats[indexPath.row][@"quiz_name"], self.stats[indexPath.row][@"score"]];
    return cell;
}


@end
