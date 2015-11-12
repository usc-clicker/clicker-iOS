//
//  JLCreateAccountViewController.m
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLCreateAccountViewController.h"
#import "ClickerConstants.h"
#import "JLAPIManager.h"
#import "JLClickerUserManager.h"

@interface JLCreateAccountViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation JLCreateAccountViewController

//use regex to check to see if create button should be enabled

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180.0f;
}

- (IBAction)createAccountAction:(id)sender {
    [JLAPIManager createAccountWithUsername:self.usernameTextField.text
                        andPassword:self.passwordTextField.text
                      andCompletion:^(completionParams) {
                          NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                          NSLog(@"dictionary: %@", dictionary);
                          if (dictionary[kErrorKey]) {
                              NSLog(@"error: %@", dictionary[kErrorKey]);
                          }
                          else {
                              NSString * userID = dictionary[@"auth"][@"id"];
                              [JLClickerUserManager setLoggedIn:userID];
                              [self dismissViewControllerAnimated:YES completion:^{
                                  [self.delegate dismiss];
                              }];
                          }
                      }];
}

@end
