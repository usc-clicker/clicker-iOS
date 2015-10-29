//
//  LoginViewController.h
//  clicker
//
//  Created by Julia Lin on 10/15/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *goButton;


- (IBAction)goButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end
