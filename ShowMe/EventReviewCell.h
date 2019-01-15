//
//  EventReviewCell.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventReviewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *reviewUserName;
@property (strong, nonatomic) IBOutlet UILabel *userReview;
@property (strong, nonatomic) IBOutlet UIImageView *reviewUserImage;

@end
