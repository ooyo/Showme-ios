//
//  OtherUserProfileViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 10/21/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListViewController.h"
#import "UserBonusListViewController.h"
#import "UserEventListViewController.h"
#import <CDRTranslucentSideBar.h>
#import "SMBInternetConnectionIndicator.h"
#import "GlobalVariables.h"
#import "MBProgressHUD.h"
#import "JPTabViewController.h"
#import "RemoteImageHandler.h" 
@interface OtherUserProfileViewController : UIViewController<MBProgressHUDDelegate,UIGestureRecognizerDelegate, NSURLSessionDelegate, CDRTranslucentSideBarDelegate>
{
    NSUserDefaults *defaults;
    NSDictionary *dictionary;
    NSString *selectedUserID;
    NSMutableData *receivedData;
    MBProgressHUD *hud;
}
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (nonatomic)  NSString *selectedUserID;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userFollow;
@property (weak, nonatomic) IBOutlet UIView *userImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@end
