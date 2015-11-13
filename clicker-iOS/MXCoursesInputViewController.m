//
//  MXCoursesInputViewController.m
//  clicker
//
//  Created by Michael on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "MXCoursesInputViewController.h"
#import "JLAPIManager.h"
#import "ClickerConstants.h"

@interface MXCoursesInputViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *courseField;
@property (weak, nonatomic) IBOutlet UITextField *sectionField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;


@end

@implementation MXCoursesInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.courseField becomeFirstResponder];
    //self.saveButton.enabled = NO;
}

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
- (IBAction)cancelButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)saveButtonTapped:(id)sender {
    
//    [JLAPIManager enrollClassWithUsername:@"abc123@usc.edu"
//                             andSectionID:self.sectionField.text.intValue
//                            andCompletion:^(NSURLResponse *response, NSData *data, NSError *error) {
//                                NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
//                                
//                                NSLog(@"dictionary: %@", dictionary);
//                                if (dictionary[kErrorKey]) {
//                                    NSLog(@"enroll error");
//                                }
//                                else {
//                                    [self enrollSuccess];
//                                }
//                            }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)enrollSuccess {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
