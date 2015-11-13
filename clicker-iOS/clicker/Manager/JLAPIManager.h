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
+(void)loginWithUsername:(NSString *)email
             andPassword:(NSString *)password
           andCompletion:(completionHandler)completion;
+(void)createAccountWithUsername:(NSString *)email
                     andPassword:(NSString *)password
                   andCompletion:(completionHandler)completion;
+(void)enrollClassWithUsername:(NSString *)email
                  andSectionID:(int )section
                 andCompletion:(completionHandler)completion;
+(void)submitAnswerWithDictionary:(NSDictionary *)jsonDict
                       completion:(completionHandler)completion;
+(void)getStatsWithUsername:(NSString *)email
              andCompletion:(completionHandler) completion;

@end
