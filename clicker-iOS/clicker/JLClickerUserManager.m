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
    if([[NSUserDefaults standardUserDefaults] objectForKey:kLoggedIn])
        return YES;
    else return NO;
}
+(void)setLoggedIn:(NSString *)userEmail {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userEmail forKey:kLoggedIn];
    [defaults synchronize];
}
+(void)setLoggedOut {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kLoggedIn];
    [defaults synchronize];
}
+(NSString *)user {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kLoggedIn];
}
@end
