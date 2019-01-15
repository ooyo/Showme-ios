//
//  ViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JOLImageSlider.h" 
#import "UIImageView+AnimationCompletion.h"
#import <AVFoundation/AVFoundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

static const float PLAYER_VOLUME = 0.0;
@interface ViewController : UIViewController <JOLImageSliderDelegate>
- (IBAction)animateBtn:(id)sender;
@property (nonatomic) AVPlayer *player;
@property (strong, nonatomic) IBOutlet UIButton *animationBtn;  

@property (strong, nonatomic) IBOutlet UIView *videoView;
@end

