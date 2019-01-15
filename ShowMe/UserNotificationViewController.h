//
//  UserNotificationViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 11/3/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNotificationTableViewCell.h"
#import "GlobalVariables.h"

#import "BIZPopupViewController.h"
#import "OtherEventViewController.h"
@class ProfileViewController;


@interface UserNotificationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>{
    
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSString *selectedUserID;
    NSMutableData *receivedData;
} 
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak) UIViewController *popupController;
@end
