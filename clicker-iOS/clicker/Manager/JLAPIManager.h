//
//  JLAPIManager.h
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClickerConstants.h"

@interface JLAPIManager : NSObject
+(void)loginWithUsername:(NSString *)username
             andPassword:(NSString *)password
           andCompletion:(completionHandler)completion;
@end
