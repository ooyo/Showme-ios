//
//  EventSlideCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EventSlideCell.h"

@implementation EventSlideCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.eventGoingBtn.layer setBorderWidth:0.5];
    [self.eventGoingBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.eventInterestedBtn.layer setBorderWidth:0.5];
    [self.eventInterestedBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.eventShareBtn.layer setBorderWidth:0.5];
    [self.eventShareBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goingButtonCell:(id)sender {
    if (self.buttonGoingTapAction) {
        self.buttonGoingTapAction(sender);
    }
}

- (IBAction)interestButtonCell:(id)sender {
    if (self.buttonInterestTapAction) {
        self.buttonInterestTapAction(sender);
    }
}

- (IBAction)shareButtonCell:(id)sender {
    if (self.buttonShareTapAction) {
        self.buttonShareTapAction(sender);
    }
}

- (IBAction)buttonNothing:(id)sender {
    if(self.buttonNothingTapAction){
        self.buttonNothingTapAction(sender);
    }
}
@end
