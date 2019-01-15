//
//  UserListTableCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListTableCell : UITableViewCell
//@property (weak, nonatomic) IBOutlet UIWebView *cellUserImage;
@property (weak, nonatomic) IBOutlet UILabel *cellUserName;
@property (weak, nonatomic) IBOutlet UILabel *cellUserInfo;
- (IBAction)userFollowButtonCell:(id)sender;
@property (nonatomic, copy) void (^buttonUserFollowTapAction)(id sender);
@property (weak, nonatomic) IBOutlet UIImageView *cellUserImage1;
@property (weak, nonatomic) IBOutlet UIButton *userFollow;
@end
