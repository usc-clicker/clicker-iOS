//
//  JLCurrentClassViewController.m
//  clicker
//
//  Created by Julia Lin on 10/28/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLCurrentClassViewController.h"
#import "ClickerConstants.h"
#import "JLClickerUserManager.h"
#import "MXProfileViewController.h"

@interface JLCurrentClassViewController ()
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@end

@implementation JLCurrentClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];

    self.view.backgroundColor = [UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1.0];
    
    [_classLabel setFont:[UIFont fontWithName:@"Helvetica" size:27.0]];
    
    UIBarButtonItem *classesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Books"] style:UIBarButtonItemStylePlain target:self action:@selector(classesButtonPressed)];
    //[classesButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Person"] style:UIBarButtonItemStylePlain target:self action:@selector(profileButtonPressed)];
    //[profileButton setTintColor:[UIColor whiteColor]];
    
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:classesButton, profileButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
}

-(void)viewDidAppear:(BOOL)animated {
    if (![JLClickerUserManager loggedIn]) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

-(void)classesButtonPressed {
    [self performSegueWithIdentifier:@"classes" sender:self];
}

-(void) profileButtonPressed {
    [self performSegueWithIdentifier:@"profile" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"profile"]) {
        MXProfileViewController * vc = segue.destinationViewController;
        vc.delegate = self;
    }
}
@end
