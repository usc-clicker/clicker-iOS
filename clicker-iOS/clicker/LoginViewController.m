//
//  LoginViewController.m
//  clicker
//
//  Created by Julia Lin on 10/15/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController () <UITextFieldDelegate>

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.goButton.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
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
    // you can have multiple textfields here
    
    
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
    [self performSegueWithIdentifier:@"login" sender:self];
    //API call
    NSString *url_str = @"http://fontify.usc.edu";
    [self send_request:url_str];
}

- (void)send_request:(NSString *)url_str {
    NSURL *url = [NSURL URLWithString:url_str];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


@end
