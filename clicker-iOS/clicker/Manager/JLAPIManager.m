//
//  JLAPIManager.m
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import "JLAPIManager.h"
#import "ClickerConstants.h"

@implementation JLAPIManager

+(void)setMethod:(JLAPIMethod)method forRequest:(NSMutableURLRequest *)request {
    NSString * m = @"";
    switch (method) {
        case GET:
            m = @"GET";
            break;
        case POST:
            m = @"POST";
            break;
    }
    [request setHTTPMethod:m];
    return;
}

+(void)makeRequestwithURL:(NSString *)url
                andMethod:(JLAPIMethod)method
                  andBody:(NSString *)body
     andCompletionHandler:(completionHandler)completion {
    NSLog(@"url: %@", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [self setMethod:method forRequest:request];
    
    //appending body
    NSData *postData = [body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:completion];
    
}

+(void)loginWithUsername:(NSString *)email
             andPassword:(NSString *)password
           andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", email);
    NSLog(@"PASSWORD: %@", password);
    
    NSString * urlString = [NSString stringWithFormat:@"%@/auth/login", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

+(void)createAccountWithUsername:(NSString *)email
             andPassword:(NSString *)password
           andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", email);
    NSLog(@"PASSWORD: %@", password);
    
    NSString * urlString = [NSString stringWithFormat:@"%@/auth/register", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"email=%@&password=%@", email, password];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

// create method to enroll user in class, model it after above methods
// MX
+(void)enrollClassWithUsername:(NSString *)email
                  andSection:(int )section
                 andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", email);
    NSLog(@"SECTION: %d", section);

    NSString * urlString = [NSString stringWithFormat:@"%@/user/enroll", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"email=%@&sectionid=%d", email, section];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

@end














