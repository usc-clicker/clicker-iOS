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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    self.usernameTextField.text = @"test0001@usc.edu";
//    self.passwordTextField.text = @"password";
    self.goButton.enabled = YES;
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
    //NSLog(@"string: %@", changedString);
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
//    [UIView animateWithDuration:0.5 animations:^{
//        if (self.goButton.enabled) {
//            self.goButton.backgroundColor = [UIColor yellowColor];
//        }
//        else{
//            self.goButton.backgroundColor = [UIColor redColor];
//        }
//    }];
    return self.goButton.enabled;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.passwordTextField resignFirstResponder];
    [self.usernameTextField resignFirstResponder];
    
}

- (void)keyboardFrameDidChange:(NSNotification *)notification{
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    CGRect newFrame = self.view.frame;
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y)/2.0;
    self.view.frame = newFrame;
    [UIView commitAnimations];
    
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
    //NSLog(@"login success");
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
