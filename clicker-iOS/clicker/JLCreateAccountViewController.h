//
//  JLCreateAccountViewController.h
//  clicker
//
//  Created by Julia Lin on 11/3/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CreateAccountViewControllerProtocol <NSObject>

-(void)dismiss;

@end

@interface JLCreateAccountViewController : UITableViewController
@property (nonatomic, weak) id delegate;
@end
