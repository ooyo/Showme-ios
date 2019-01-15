//
//  EventReviewSendCell.m
//  ShowMe
//
//  Created by Nuk3denE on 6/26/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EventReviewSendCell.h"

@implementation EventReviewSendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.writeReviewBtn.layer setCornerRadius:5.0f];
    [self.writeReviewBtn.layer setMasksToBounds:YES];
    [self.writeReviewBtn.layer setBorderWidth:1.0f];
    [self.writeReviewBtn.layer setBorderColor:[UIColor colorWithRed:38.f/255.f green:156.f/255.f blue:187.f/255.f alpha:1.0].CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)seeButtonCell:(id)sender{
    if (self.buttonSeeTapAction) {
        self.buttonSeeTapAction(sender);
    }
}
- (IBAction)writeButtonCell:(id)sender{
    if (self.buttonWriteTapAction) {
        self.buttonWriteTapAction(sender);
    }
}
@end
