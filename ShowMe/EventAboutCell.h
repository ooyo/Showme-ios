//
//  EventAboutCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventAboutCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *eventAboutText;
@property (strong, nonatomic) IBOutlet UIButton *field2Btn;
@property (strong, nonatomic) IBOutlet UIButton *field1Btn;
@property (strong, nonatomic) IBOutlet UIButton *filed3Btn;

@property (nonatomic, copy) void (^buttonField1TapAction)(id sender);
@property (nonatomic, copy) void (^buttonField2TapAction)(id sender);
@property (nonatomic, copy) void (^buttonField3TapAction)(id sender);
- (IBAction)field1ButtonCell:(id)sender;
- (IBAction)field2ButtonCell:(id)sender;
- (IBAction)field3ButtonCell:(id)sender;
@end
