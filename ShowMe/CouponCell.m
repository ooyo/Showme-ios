//
//  CouponCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect frame2 = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cardMainView.frame.size.height+1);
    self.cardMainView.frame = frame2;
    [self.cardMainView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.cardMainView.layer setBorderWidth:0.5f];
        [self cardSetup:self.cardMainView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)cardSetup: (UIView *) cardView{
    [cardView setAlpha:1];
    cardView.layer.masksToBounds = NO;
    cardView.layer.cornerRadius = 1;
    cardView.layer.shadowOffset = CGSizeMake(-.2f, .2f);
    cardView.layer.shadowRadius = 1;
    // NSLog(@"Card view Size Width: %f Height: %f", cardView.bounds.size.width, cardView.bounds.size.height);
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:cardView.bounds];
    cardView.layer.shadowPath =path.CGPath;
    cardView.layer.shadowOpacity = 0.2;
    [cardView.layer setCornerRadius:5.0f];
    [cardView.layer setMasksToBounds:YES];
    
}
@end
