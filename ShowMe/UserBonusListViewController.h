//
//  UserBonusListViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponCell.h"
#import "GlobalVariables.h"
#import "BIZPopupViewController.h"
#import "OtherEventViewController.h"
@interface UserBonusListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLSessionDelegate>{

    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSString *selectedUserID;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSString *selectedUserID;
@property (weak) UIViewController *popupController;
@end
