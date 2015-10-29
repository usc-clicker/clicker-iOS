//
//  JLCurrentClassViewController.m
//  clicker
//
//  Created by Julia Lin on 10/28/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLCurrentClassViewController.h"

@interface JLCurrentClassViewController ()
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@end

@implementation JLCurrentClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *classesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Courses"] style:UIBarButtonItemStylePlain target:self action:@selector(classesButtonPressed)];
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Profile"] style:UIBarButtonItemStylePlain target:self action:@selector(profileButtonPressed)];
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:classesButton, profileButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];

}

-(void)viewDidAppear:(BOOL)animated {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"kLoggedIn"] == nil || [[NSUserDefaults standardUserDefaults] objectForKey:@"kLoggedIn"] == NO) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

-(void)classesButtonPressed {
    [self performSegueWithIdentifier:@"classes" sender:self];
}

-(void) profileButtonPressed {
    
}

@end
