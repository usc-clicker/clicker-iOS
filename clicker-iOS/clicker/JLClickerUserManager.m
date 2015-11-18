//
//  JLClickerUser.m
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLClickerUserManager.h"
#import "ClickerConstants.h"
#import "JLAPIManager.h"
#import <Parse/Parse.h>

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
    //subscribe to channels
    [JLAPIManager getClassesWithUsername:[JLClickerUserManager user]
                           andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                               NSArray * courses = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] mutableCopy];
                               NSLog(@"courses %@", courses);
                               
                               PFInstallation * currentInstallation = [PFInstallation currentInstallation];
                               for (id course in courses) {
                                   NSString * sectionID = [NSString stringWithFormat:@"s%@", course[@"section_id"]];
                                   [currentInstallation addUniqueObject:sectionID forKey:@"channels"];
                               }
                               [currentInstallation saveInBackground];
                           }];
}
+(void)setLoggedOut {
    //    //unsubscribe to all channels
    [JLAPIManager getClassesWithUsername:[JLClickerUserManager user]
                           andCompletion:^(NSURLResponse * response, NSData * data, NSError * error) {
                               if (data) {
                                   NSArray * courses = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error] mutableCopy];
                                   NSLog(@"courses %@", courses);
                                   
                                   PFInstallation * currentInstallation = [PFInstallation currentInstallation];
                                   for (id course in courses) {
                                       NSLog(@"course %@", course);
                                       NSString * sectionID = [NSString stringWithFormat:@"s%@", course[@"section_id"]];
                                       NSLog(@"sectionID: %@", sectionID);
                                       [currentInstallation removeObject:sectionID forKey:@"channels"];
                                   }
                                   [currentInstallation saveInBackground];
                               }
                           }];
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kLoggedIn];
    [defaults synchronize];
}
+(NSString *)user {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kLoggedIn];
}
@end
