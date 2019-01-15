//
//  ProfileViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListViewController.h"
#import "UserBonusListViewController.h"
#import "UserEventListViewController.h"
#import <CDRTranslucentSideBar.h>
#import "SMBInternetConnectionIndicator.h"
#import "GlobalVariables.h"
#import "JPTabViewController.h"
#import "RemoteImageHandler.h"
#import "SWRevealViewController.h"
#import "MBProgressHUD.h"
#import "MKNumberBadgeView.h"
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "UserNotificationViewController.h"

@interface ProfileViewController : UIViewController <UIGestureRecognizerDelegate,MBProgressHUDDelegate, NSURLSessionDelegate, CDRTranslucentSideBarDelegate, FPPopoverControllerDelegate>
{MBProgressHUD *hud;
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSMutableData *receivedData;
    CGFloat _keyboardHeight;
    MKNumberBadgeView *number;
}


@property (weak, nonatomic) IBOutlet UIButton *userNotifBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *userMenu;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *userNotif;

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *userMenu2;
- (IBAction)userNotificationAction:(id)sender;
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@property (weak, nonatomic) IBOutlet UIView *userMainView;
@property (weak, nonatomic) IBOutlet UILabel *userFollowing;

@property (nonatomic, strong) CDRTranslucentSideBar *sideBar;
@property (weak, nonatomic) IBOutlet UIView *userProfileImageBg;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImage;
@end
