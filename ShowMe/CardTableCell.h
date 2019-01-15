//
//  CardTableCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIWebView *cardImageWebView;
@property (strong, nonatomic) IBOutlet UILabel *cartTitle;
@property (strong, nonatomic) IBOutlet UIImageView *cardCategoryImage;
@property (strong, nonatomic) IBOutlet UIImageView *cardUserImage0;
@property (strong, nonatomic) IBOutlet UIImageView *cardUserImage1;
@property (strong, nonatomic) IBOutlet UIImageView *cardUserImage2;
@property (strong, nonatomic) IBOutlet UILabel *cardUserLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardBadge;

@property (strong, nonatomic) IBOutlet UIButton *cardUserBtn;
@property (strong, nonatomic) IBOutlet UILabel *cardTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *cardLikeLabel;
@property (strong, nonatomic) IBOutlet UIView *cardGradientView;
@property (strong, nonatomic) IBOutlet UIView *cardMainView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)userButtonCell:(id)sender;
@property (nonatomic, copy) void (^buttonUserTapAction)(id sender);
@end
