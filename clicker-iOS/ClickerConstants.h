//
//  ClickerConstants.h
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#ifndef ClickerConstants_h
#define ClickerConstants_h

typedef enum {
    GET = 1,
    POST
} JLAPIMethod;

#define kLoggedIn @"kLoggedIn"
#define kErrorKey @"error"
#define kOkay @"Okay"
#define kLoginErrorTitle @"Login Error!"

#define BASE_URL @"http://fontify.usc.edu"

typedef void (^completionHandler)(NSURLResponse *response, NSData *data, NSError *error);

#endif /* ClickerConstants_h */
