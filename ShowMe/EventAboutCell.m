//
//  EventAboutCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EventAboutCell.h"

@implementation EventAboutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.field1Btn.layer setBorderColor:[UIColor colorWithRed:140.f/255.f green:140.f/255.f blue:140.f/255.f alpha:1.0].CGColor];
     [self.field1Btn.layer setBorderWidth:0.5];
    
    [self.field2Btn.layer setBorderColor:[UIColor colorWithRed:140.f/255.f green:140.f/255.f blue:140.f/255.f alpha:1.0].CGColor];
    [self.field2Btn.layer setBorderWidth:0.5];
    
    [self.filed3Btn.layer setBorderColor:[UIColor colorWithRed:140.f/255.f green:140.f/255.f blue:140.f/255.f alpha:1.0].CGColor];
    [self.filed3Btn.layer setBorderWidth:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)field1ButtonCell:(id)sender{
    if (self.buttonField1TapAction) {
        self.buttonField1TapAction(sender);
    }
}
- (IBAction)field2ButtonCell:(id)sender{
    if (self.buttonField2TapAction) {
        self.buttonField2TapAction(sender);
    }
}
- (IBAction)field3ButtonCell:(id)sender{
    if (self.buttonField3TapAction) {
        self.buttonField3TapAction(sender);
    }
}
@end
