//
//  UserListTableCell.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserListTableCell.h"

@implementation UserListTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.cellUserImage1.layer setCornerRadius:self.cellUserImage1.frame.size.width / 2];
    [self.cellUserImage1.layer setMasksToBounds:YES];
    [self.cellUserImage1.layer setBorderWidth:0.5f];
    [self.cellUserImage1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.userFollow.layer setCornerRadius:5.0];
    [self.userFollow.layer setBorderColor:[UIColor colorWithRed:22.0/255.0 green:176.0/255.0 blue:243.0/255.0 alpha:1.0].CGColor];
    [self.userFollow.layer setBorderWidth:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)userFollowButtonCell:(id)sender {
    if (self.buttonUserFollowTapAction) {
        self.buttonUserFollowTapAction(sender);
    }
}
@end
