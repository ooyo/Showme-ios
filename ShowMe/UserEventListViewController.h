//
//  UserEventListViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RoundCardImage.h"
#import "CardTableCell.h"
#import "GlobalVariables.h"
#import "RemoteImageHandler.h"
#import "HomeUserListViewController.h"
#import "BIZPopupViewController.h"
#import "OtherEventViewController.h"
@interface UserEventListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>{
    
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSString *selectedUserID;
    NSString *selectedEventID;
    NSMutableData *receivedData;
    
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;

@property (weak) UIViewController *popupController;
@property (nonatomic) NSString *selectedUserID;
@end
