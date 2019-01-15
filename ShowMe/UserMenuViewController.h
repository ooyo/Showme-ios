//
//  UserMenuViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 10/19/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginManager.h>
#import <FBSDKCoreKit/FBSDKAccessToken.h>
#import "RemoteImageHandler.h"
#import "EAIntroView.h"
@interface UserMenuViewController : UIViewController <EAIntroDelegate>{

 NSArray *menuItems;

}
@property (weak, nonatomic) IBOutlet UIView *userImageBorder;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
