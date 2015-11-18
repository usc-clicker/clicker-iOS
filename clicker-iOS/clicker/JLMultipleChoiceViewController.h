//
//  JLMultipleChoiceViewController.h
//  clicker
//
//  Created by Julia Lin on 11/9/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLMultipleChoiceViewController : UITableViewController

@property (strong, nonatomic) NSString * questionString;
@property (strong, nonatomic) NSArray * answersArray;
@property (strong, nonatomic) NSNumber * timeLimit;
@property (strong, nonatomic) NSNumber * showAnswer;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timerLabel;

@property (nonatomic) NSInteger questionID;
@property (nonatomic, strong) NSString * quizID;
- (IBAction)submitButtonAction:(id)sender;

@end
