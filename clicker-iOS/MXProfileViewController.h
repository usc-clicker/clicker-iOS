//
//  MXProfileViewController.h
//  clicker
//
//  Created by Michael on 11/5/15.
//  Copyright © 2015 Univeristy of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MXProfileViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (IBAction)logoutButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *statsTableView;
@property (nonatomic, weak) id delegate;
@end
