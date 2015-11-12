//
//  JLMultipleChoiceViewController.h
//  clicker
//
//  Created by Julia Lin on 11/9/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLMultipleChoiceViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSString * questionString;
@property (strong, nonatomic) NSArray * answersArray;
@property (strong, nonatomic) NSNumber * timeLimit;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)submitButtonAction:(id)sender;

@end
