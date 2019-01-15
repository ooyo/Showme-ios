//
//  EventReviewCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EventReviewCell.h"

@implementation EventReviewCell

- (void)awakeFromNib {
    [super awakeFromNib];
   [self layoutIfNeeded];
    [self.reviewUserImage.layer setCornerRadius:self.reviewUserImage.frame.size.width/2];
    [self.reviewUserImage.layer setBorderWidth:0.5f];
    [self.reviewUserImage.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.reviewUserImage setClipsToBounds:YES]; 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
