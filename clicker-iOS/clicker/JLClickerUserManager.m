//
//  JLClickerUser.m
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLClickerUserManager.h"
#import "ClickerConstants.h"

@implementation JLClickerUserManager
+(BOOL)loggedIn {
    BOOL test = [[[NSUserDefaults standardUserDefaults] objectForKey:kLoggedIn] boolValue];
    NSLog(@"test: %d", test);
    return test;
}
+(void)setLoggedIn {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:kLoggedIn];
    [defaults synchronize];
}
+(void)setLoggedOut {
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kLoggedIn];
    [defaults synchronize];
}
@end
