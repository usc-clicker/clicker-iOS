//
//  JLClickerUser.h
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLClickerUserManager : NSObject
+(void)setLoggedIn;
+(void)setLoggedOut;
+(BOOL)loggedIn;
@end
