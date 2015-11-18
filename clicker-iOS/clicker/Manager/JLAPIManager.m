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

+(void)makeJsonRequestwithURL:(NSString *)url
                    andMethod:(JLAPIMethod)method
                      andBody:(NSDictionary *)parameters
         andCompletionHandler:(completionHandler)completion {
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [self setMethod:method forRequest:request];
    NSError * error;
    id jsondata = [NSJSONSerialization dataWithJSONObject:parameters
                                               options:NSJSONWritingPrettyPrinted
                                                    error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[jsondata length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:jsondata];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:completion];
    
}


+(void)makeFormRequestwithURL:(NSString *)url
                andMethod:(JLAPIMethod)method
                  andBody:(NSString *)body
     andCompletionHandler:(completionHandler)completion {
    NSLog(@"url: %@", url);
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [self setMethod:method forRequest:request];
    
    if(body) {
    //appending body
        NSData *postData = [body dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[postData length]];
        
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
    }
    
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
    
    [JLAPIManager makeFormRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

+(void)submitAnswerWithDictionary:(NSDictionary *)jsonDict
                       completion:(completionHandler)completion {
    NSLog(@"jsonDict: %@", jsonDict);
    NSString * urlString = [NSString stringWithFormat:@"%@/question/answer", BASE_URL];
    [JLAPIManager makeJsonRequestwithURL:urlString
                           andMethod:POST
                                 andBody:jsonDict
                andCompletionHandler:completion];
}

+(void)createAccountWithUsername:(NSString *)email
                    andStudentId:(NSString *)uscId
                     andPassword:(NSString *)password
                   andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", email);
    NSLog(@"PASSWORD: %@", password);
    
    NSString * urlString = [NSString stringWithFormat:@"%@/auth/register", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"email=%@&password=%@&usc_id=%@", email, password, uscId];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeFormRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

+(void)getStatsWithUsername:(NSString *)email
              andCompletion:(completionHandler) completion {
    NSString * urlString = [NSString stringWithFormat:@"%@/user/stats", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"user=%@", email];
//    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlString = [NSString stringWithFormat:@"%@?%@", urlString, body];
    [JLAPIManager makeFormRequestwithURL:urlString
                               andMethod:GET
                                 andBody:nil
                    andCompletionHandler:completion];
}

+(void)getClassesWithUsername:(NSString *)email
              andCompletion:(completionHandler) completion {
    NSString * urlString = [NSString stringWithFormat:@"%@/user/classes", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"user=%@", email];
    urlString = [NSString stringWithFormat:@"%@?%@", urlString, body];
    [JLAPIManager makeFormRequestwithURL:urlString
                               andMethod:GET
                                 andBody:nil
                    andCompletionHandler:completion];
}



+(void)enrollClassWithUsername:(NSString *)email
                  andSectionID:(NSString *)section
                 andCompletion:(completionHandler)completion {
    NSLog(@"USERNAME: %@", email);
    NSLog(@"SECTION: %@", section);

    NSString * urlString = [NSString stringWithFormat:@"%@/user/enroll", BASE_URL];
    
    NSString * body = [NSString stringWithFormat:@"user=%@&section_id=%@", email, section];
    [body stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [JLAPIManager makeFormRequestwithURL:urlString
                           andMethod:POST
                             andBody:body
                andCompletionHandler:completion];
}

@end














