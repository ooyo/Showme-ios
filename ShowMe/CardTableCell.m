//
//  CardTableCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "CardTableCell.h"

@implementation CardTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [self layoutIfNeeded];
    CGRect frame2 = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.cardMainView.frame.size.height+1);
    self.cardMainView.frame = frame2;
    
    self.cardCategoryImage.contentMode = UIViewContentModeScaleAspectFit;
    self.cardCategoryImage.clipsToBounds = YES;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.cardMainView.bounds;
    
    
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor colorWithRed:25.0f/255.0f green:25.0f/255.0f blue:25.0f/255.0f alpha:0.8] CGColor], nil];
    [_cardGradientView.layer insertSublayer:gradient atIndex:0];

    
    //CGRect frame2 = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-20, self.cardMainView.frame.size.height+1);
    //self.cardMainView.frame = frame2;
    
    [self.bottomView.layer setMasksToBounds:NO];
    [self.bottomView.layer setCornerRadius:3.0f];
    [self cardSetup:self.cardMainView];
    
    
    
    [self.cardUserImage0.layer setCornerRadius:self.cardUserImage0.layer.frame.size.width /2];
    [self.cardUserImage0 setClipsToBounds:YES];
    
    [self.cardUserImage1.layer setCornerRadius:self.cardUserImage0.layer.frame.size.width /2];
    [self.cardUserImage1 setClipsToBounds:YES];
    
    [self.cardUserImage2.layer setCornerRadius:self.cardUserImage0.layer.frame.size.width /2];
    [self.cardUserImage2 setClipsToBounds:YES];
    
    [self.cardUserLabel.layer setCornerRadius:self.cardUserImage0.layer.frame.size.width /2];
    [self.cardUserLabel setClipsToBounds:YES];
 //   [self.cardUserLabel setText:@"+100"];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)userButtonCell:(id)sender {
    if (self.buttonUserTapAction) {
        self.buttonUserTapAction(sender);
    }
}
@end
