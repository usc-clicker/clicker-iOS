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
    [UIView animateWithDuration:0.5 animations:^{
        if (self.goButton.enabled) {
            self.goButton.backgroundColor = [UIColor redColor];
        }
        else{
            self.goButton.backgroundColor = [UIColor blackColor];
        }
    }];
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
    
    NSString *post = [NSString stringWithFormat:@"bokunxu@gmail.com", @"password"];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[post length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://fontify.usc.edu/auth/login"]];
    
    
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    NSURLConnection *connected = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connected) {
        NSLog(@"Connection Successful");
    } else {
        NSLog(@"Connection could not be made");
    }
    
}

/*
 this method might be calling more than one times according to incoming data size
 */
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [self.receivedData appendData:data];
}
/*
 if there is an error occured, this method will be called by connection
 */
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@" , error);
}

/*
 if data is successfully received, this method will be called by connection
 */
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    //initialize convert the received data to string with UTF8 encoding
    NSString *htmlSTR = [[NSString alloc] initWithData:self.receivedData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"%@" , htmlSTR);
    //initialize a new webviewcontroller
    //UIViewController *controller = [[UIViewController alloc] initWithString:htmlSTR];
    
    //show controller with navigation
    //[self.navigationController pushViewController:controller animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


@end




















