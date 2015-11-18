//
//  JLCoursesViewController.m
//  clicker
//
//  Created by Julia Lin on 10/28/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLCoursesViewController.h"
#import "MXCoursesInputViewController.h"
#import "JLAPIManager.h"
#import "JLClickerUserManager.h"
#import <Parse/Parse.h>

@interface JLCoursesViewController ()
@property (nonatomic, strong) NSMutableArray * courses;
@property (nonatomic, strong) UIRefreshControl * refreshControl;
@end

@implementation JLCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getClasses)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
//    [self.navigationController.navigationBar
//     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
//    [self.navigationController.navigationBar setTintColor:[UIColor redColor]];
    // Do any additional setup after loading the view.
}

-(void)getClasses {
    [self.refreshControl beginRefreshing];
    [JLAPIManager getClassesWithUsername:[JLClickerUserManager user]
                           andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                               self.courses = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] mutableCopy];
                               NSLog(@"classes; %@", self.courses);
                               [self.tableView reloadData];
                               [self.refreshControl endRefreshing];
                           }];
}

-(void)viewWillAppear:(BOOL)animated {
    [self getClasses];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"eventCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
   
    cell.textLabel.text = self.courses[indexPath.row][@"course_id"];
    cell.detailTextLabel.text = self.courses[indexPath.row][@"instructor"];

    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Unenroll";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString * sectionId = self.courses[indexPath.row][@"section_id"];
        //send unenroll
        [JLAPIManager unenrollClassWithUsername:[JLClickerUserManager user]
                                   andSectionID:sectionId
                                  andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                                      PFInstallation *currentInstallation = [PFInstallation currentInstallation];
                                      [currentInstallation removeObject:[NSString stringWithFormat:@"s%@", sectionId] forKey:@"channels"];
                                      [currentInstallation saveInBackground];
                                  }];
        //delete the cell
        [self.courses removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

@end
