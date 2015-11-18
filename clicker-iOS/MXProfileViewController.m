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
                          if (data) {
                              self.stats = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                              NSLog(@"stats: %@", self.stats);
#warning assuming it works
                              
                              //                          if (dictionary[kErrorKey]) {
                              //                              [self getStatsFailedWithError:(dictionary[kErrorKey])];
                              //                          }
                              //                          else {
                              [self getStatsSuccess];
                              //                          }
                          }
                      }];
}


-(void)getStatsSuccess {
    [self.tableView reloadData];
}

-(void)getStatsFailedWithError:(NSError *) error {
    
}

- (void)logout {
    [JLClickerUserManager setLoggedOut];
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.stats.count;
    }
    else
        return 1;
}

-(NSString *)truncateNumberTo2Places:(NSNumber *)number{
    return [NSString stringWithFormat:@"%.2f", [number floatValue]];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *statsCell = @"statsCell";
    static NSString *logoutCell = @"logoutCell";
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:statsCell];
        NSString * quizName = self.stats[indexPath.row][@"quiz_name"];
        NSString * score = [self truncateNumberTo2Places:self.stats[indexPath.row][@"score"]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", quizName, score];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:logoutCell];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        //logout
        [self logout];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Statistics";
        case 1:
            return @"User";
        default:
            return @"Other";
    }
}

@end
