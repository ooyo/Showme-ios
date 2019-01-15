//
//  UserNotificationTableViewCell.h
//  ShowMe
//
//  Created by Nuk3denE on 11/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNotificationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIWebView *userNotifImage;
@property (weak, nonatomic) IBOutlet UILabel *userNotifText;
@end
