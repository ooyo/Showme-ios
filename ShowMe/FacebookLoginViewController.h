//
//  FacebookLoginViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/27/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "GlobalVariables.h"
#import <TSMessage.h>
#import <TSMessageView.h>
#import "EAIntroView.h"
@interface FacebookLoginViewController : UIViewController <NSURLSessionDelegate,MBProgressHUDDelegate, TSMessageViewProtocol, EAIntroDelegate>
{
    MBProgressHUD *hud;
    NSDictionary *dictionary;
}
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIView *facebookView;
@end
