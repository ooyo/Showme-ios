//
//  CouponCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CouponCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bonusBG;
@property (strong, nonatomic) IBOutlet UILabel *bonusPlace;
@property (strong, nonatomic) IBOutlet UILabel *bonusDescription;
@property (strong, nonatomic) IBOutlet UIView *cardMainView;

@end
