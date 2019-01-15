//
//  EventSlideCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventSlideCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *slideCellTitle;
@property (strong, nonatomic) IBOutlet UIImageView *eventMainImage;
@property (strong, nonatomic) IBOutlet UIButton *eventGoingBtn;
@property (strong, nonatomic) IBOutlet UIButton *eventInterestedBtn;
@property (strong, nonatomic) IBOutlet UIButton *eventShareBtn;
@property (nonatomic, copy) void (^buttonGoingTapAction)(id sender);
@property (nonatomic, copy) void (^buttonInterestTapAction)(id sender);
@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (nonatomic, copy) void (^buttonShareTapAction)(id sender);
- (IBAction)goingButtonCell:(id)sender;
- (IBAction)interestButtonCell:(id)sender;
- (IBAction)shareButtonCell:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *goingCount;
@property (strong, nonatomic) IBOutlet UIButton *interestCount;
@property (strong, nonatomic) IBOutlet UIButton *eventAddress;
@property (strong, nonatomic) IBOutlet UIButton *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *imageCount;
    
- (IBAction)buttonNothing:(id)sender;
@property (nonatomic, copy) void (^buttonNothingTapAction)(id sender);
@end
