//
//  JLCoursesViewController.m
//  clicker
//
//  Created by Julia Lin on 10/28/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLCoursesViewController.h"
#import "MXCoursesInputViewController.h"

@interface JLCoursesViewController ()

@end

@implementation JLCoursesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"eventCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    }
   
    cell.textLabel.text = @"HIST 100";
    cell.detailTextLabel.text = @"Johnson";

    return cell;
}

// plus button action method, model after goButtonPressed in LoginViewController
// call method of JLAPIManager to enroll user in class
// subscribe to parse channel
// set callbacks

@end
