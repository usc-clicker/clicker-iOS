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

@interface JLCurrentClassViewController ()
@property (nonatomic, strong) NSArray * arrayOfNavigationBarButtons;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@end

@implementation JLCurrentClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    for (NSString *familyName in [UIFont familyNames]) {
//        NSLog(@"%@", familyName);
//        for (NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            NSLog(@"\t%@",fontName);
//        }
//    }
    
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setBackgroundColor:[UIColor colorWithRed:0.55 green:0.00 blue:0.10 alpha:1.0]];
    
    [_classLabel setFont:[UIFont fontWithName:@"Helvetica" size:27.0]];
    
    UIBarButtonItem *classesButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Courses"] style:UIBarButtonItemStylePlain target:self action:@selector(classesButtonPressed)];
    //[classesButton setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *profileButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Profile"] style:UIBarButtonItemStylePlain target:self action:@selector(profileButtonPressed)];
    //[profileButton setTintColor:[UIColor whiteColor]];
    
    self.arrayOfNavigationBarButtons = [NSArray arrayWithObjects:classesButton, profileButton, nil];
    [self.navigationItem setRightBarButtonItems:self.arrayOfNavigationBarButtons];
    [JLClickerUserManager setLoggedOut];
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

@end
