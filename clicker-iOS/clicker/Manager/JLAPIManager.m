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

+(void)loginWithUsername:(NSString *)username
             andPassword:(NSString *)password
           andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", username);
    NSLog(@"PASSWORD: %@", password);
    
    NSString * urlString = [NSString stringWithFormat:@"%@/auth/login", BASE_URL];
    NSURL * url = [NSURL URLWithString:urlString];
    
    NSString * body = [NSString stringWithFormat:@"email=%@&password=%@", username, password];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

@end
