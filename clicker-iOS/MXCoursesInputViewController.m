//
//  MXCoursesInputViewController.m
//  clicker
//
//  Created by Michael on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "MXCoursesInputViewController.h"
#import "JLAPIManager.h"
#import "JLClickerUserManager.h"
#import "ClickerConstants.h"
#import <Parse/Parse.h>

@interface MXCoursesInputViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *courseField;
@property (weak, nonatomic) IBOutlet UITextField *sectionField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;


@end

@implementation MXCoursesInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.sectionField becomeFirstResponder];
//    self.saveButton.enabled = NO;
}
/*
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *changedString = [textField.text stringByReplacingCharactersInRange: range withString: string];
    
    if(textField ==self.sectionField){
        [self validateSaveButtonForText: changedString];
    }
    // Do no actually replace the text Field's text!
    // Return YES and let UIKit do it
    return YES;
}


- (void)validateSaveButtonForText: (NSString *) text {
    self.saveButton.enabled = ([text length] > 0);
}
 */
- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveButtonTapped:(id)sender {
    self.view.userInteractionEnabled = NO;
    self.navigationController.navigationBar.userInteractionEnabled = NO;
    [JLAPIManager enrollClassWithUsername:[JLClickerUserManager user]
                             andSectionID:self.sectionField.text
                            andCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
                                if (!data) {
                                    UIAlertController * ac = [UIAlertController alertControllerWithTitle:@"Error!" message:@"Section is not valid" preferredStyle:UIAlertControllerStyleAlert];
                                    [ac addAction:[UIAlertAction actionWithTitle:@"Okay!" style:UIAlertActionStyleDefault handler:nil]];
                                    [self presentViewController:ac animated:YES completion:^{
                                        self.view.userInteractionEnabled = YES;
                                        self.navigationController.navigationBar.userInteractionEnabled = YES;
                                    }];
                                    return;
                                }
                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                                NSLog(@"dictionary: %@", dictionary);
                                if (dictionary[kErrorKey]) {
                                    NSLog(@"enroll error");
                                    self.view.userInteractionEnabled = YES;
                                    self.navigationController.navigationBar.userInteractionEnabled = YES;
                                }
                                else {
                                    [self enrollSuccess];
                                }
                            }];
}

-(void)enrollSuccess {
    
    NSString * channelName = [NSString stringWithFormat:@"s%@",self.sectionField.text];
    
    PFInstallation * currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation addUniqueObject:channelName forKey:@"channels"];
    [currentInstallation saveInBackground];
    
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:1.0];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationController.navigationBar.userInteractionEnabled = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    });
}


@end
