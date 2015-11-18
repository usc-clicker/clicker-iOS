//
//  LoginViewController.m
//  clicker
//
//  Created by Julia Lin on 10/15/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLLoginViewController.h"
#import "ClickerConstants.h"
#import "JLAPIManager.h"
#import "JLClickerUserManager.h"

@interface JLLoginViewController () <UITextFieldDelegate>

@end

@implementation JLLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.goButton.enabled = NO;
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }
    else{
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
    return YES;
}

-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateTextField:textField withString:changedString];
    return YES;
}

-(BOOL) updateTextField:(UITextField *)textfield withString:(NSString*)string{
    if (textfield == self.usernameTextField) {
        self.goButton.enabled = (string.length != 0) && (self.passwordTextField.text.length != 0);
    }
    else if(textfield == self.passwordTextField){
        self.goButton.enabled = (self.usernameTextField.text.length != 0) && (string.length != 0);
    }
    else{
        self.goButton.enabled = (self.usernameTextField.text.length != 0) && (self.passwordTextField.text.length != 0);
    }
    return self.goButton.enabled;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    
}

-(void)goButtonPressed:(id)sender {
    [JLAPIManager loginWithUsername:self.usernameTextField.text
                        andPassword:self.passwordTextField.text
                      andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                          NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                          NSLog(@"dictionary: %@", dictionary);
                          if (dictionary[kErrorKey]) {
                              [self loginFailedWithError:(dictionary[kErrorKey])];
                          }
                          else {
                              NSString * userEmail = dictionary[@"auth"][@"email"];
                              [self loginSuccess:userEmail];
                          }
                      }];
}

-(void)loginSuccess:(NSString *)userEmail {
    [JLClickerUserManager setLoggedIn:userEmail];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)loginFailedWithError:(NSString *)error {
    UIAlertController * ac = [UIAlertController alertControllerWithTitle:kLoginErrorTitle
                                                                 message:error
                                                          preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:kOkay
                                           style:UIAlertActionStyleDefault
                                         handler:nil]];
    [self presentViewController:ac
                       animated:YES
                     completion:nil];
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (IBAction)createAccountAction:(id)sender {
    [self performSegueWithIdentifier:@"createAccount" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"createAccount"]) {
        JLCreateAccountViewController * vc = segue.destinationViewController;
        vc.delegate = self;
    }
}
@end
