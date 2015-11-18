//
//  JLMultipleChoiceViewController.m
//  clicker
//
//  Created by Julia Lin on 11/9/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLMultipleChoiceViewController.h"
#import "JLAPIManager.h"
#import "JLClickerUserManager.h"

@interface JLMultipleChoiceViewController ()

@property (strong, nonatomic) NSTimer * timer;
@property (nonatomic) NSInteger timeRemaining;
@property (nonatomic) NSInteger selectedIndex;

@end

@implementation JLMultipleChoiceViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.questionLabel.text = self.questionString;
//    NSNumber * timeInSeconds = [NSNumber numberWithInt:[self.timeLimit intValue]/1000];
    self.timeRemaining = self.timeLimit.intValue/1000;
    [self updateLabel];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(decrementTimer) userInfo:nil repeats:YES];
}

- (NSString *)timeFormatted:(NSInteger)totalSeconds{
    
    NSInteger seconds = totalSeconds % 60;
    NSInteger minutes = (totalSeconds / 60) % 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
}

-(void)updateLabel {
    self.timerLabel.text = [self timeFormatted:self.timeRemaining];
}

-(void)decrementTimer {
    self.timeRemaining--;
    [self updateLabel];
    if (self.timeRemaining == 0) {
        [self.timer invalidate];
        [self dismissAndSubmit];
    }
}

- (IBAction)submitButtonAction:(id)sender {
    [self dismissAndSubmit];
}

-(void)dismissAndSubmit {
    [JLAPIManager submitAnswerWithDictionary:@{
                                               @"quiz_id":[NSString stringWithFormat:@"%@", self.quizID],
                                               @"question_id":[NSString stringWithFormat:@"%ld", (long)self.questionID],
                                               @"answer":self.answersArray[self.selectedIndex],
                                               @"location": @{
                                                       @"lat":@"-23.34534",
                                                       @"lng":@"45.25234"
                                                       },
                                               @"user":[JLClickerUserManager user]
                                               }
                                  completion:^(NSURLResponse * response, NSData * data, NSError * error) {
                                      NSLog(@"response: %@", response);
                                      NSLog(@"data: %@", data);
                                      NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                      NSLog(@"dictionary: %@", dictionary);
                                      
                                      [self dismissViewControllerAnimated:YES completion:nil];
                                  }];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"multipleChoiceAnswer";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.textLabel.text = self.answersArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.answersArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
}

@end
