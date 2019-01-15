//
//  UserListViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListTableCell.h"
#import "GlobalVariables.h"
#import "RCTagProcessor.h"
#import "UILabel+TextAttributeTags.h"
#import "BIZPopupViewController.h"
#import "OtherUserProfileViewController.h"
@interface UserListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>
{
    
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSString *selectedUserID;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak) UIViewController *popupController;
@property (nonatomic) NSString *selectedUserID;
@end
