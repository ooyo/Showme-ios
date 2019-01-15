//
//  EventReviewSendCell.h
//  ShowMe
//
//  Created by Nuk3denE on 6/26/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventReviewSendCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *allReviewBtn;
@property (strong, nonatomic) IBOutlet UIButton *writeReviewBtn;
@property (nonatomic, copy) void (^buttonSeeTapAction)(id sender);
@property (nonatomic, copy) void (^buttonWriteTapAction)(id sender);
- (IBAction)seeButtonCell:(id)sender;
- (IBAction)writeButtonCell:(id)sender;
@end
