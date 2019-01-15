//
//  FindFriendViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 11/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListTableCell.h"
#import "GlobalVariables.h"
#import "RCTagProcessor.h"
#import "UILabel+TextAttributeTags.h"
#import "BIZPopupViewController.h"
#import "OtherUserProfileViewController.h"

@interface FindFriendViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>
{
    
    UIActivityIndicatorView *spinner;
    
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSString *selectedUserID;
    NSMutableData *receivedData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;

@property (weak) UIViewController *popupController;
@property (nonatomic) NSString *selectedUserID;
- (IBAction)btnActionBack:(id)sender;

@end
