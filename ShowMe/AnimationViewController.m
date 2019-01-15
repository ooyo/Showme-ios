//
//  AnimationViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "AnimationViewController.h"
static NSString * const kTwitterIcon = @"twitterIcon";
static NSString * const kSnapchatIcon = @"snapchatIcon";

static NSString * const kTwitterColor = @"4099FF";
static NSString * const kSnapchatColor = @"FFCC00";

@interface AnimationViewController ()
@property (nonatomic, strong) CBZSplashView *splashView;
@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __unused UIImage *icon = [UIImage imageNamed:@"logo_flat"];
    //UIBezierPath *bezier = [UIBezierPath twitterShape];
    UIColor *color = [UIColor colorWithHexString:kTwitterColor];
    
    //CBZSplashView *splashView = [CBZSplashView splashViewWithBezierPath:bezier
      //                                                  backgroundColor:color];
    CBZSplashView *splashView = [CBZSplashView splashViewWithIcon:icon backgroundColor:color];
    splashView.animationDuration = 1.4;
    
    [self.view addSubview:splashView];
    
    self.splashView = splashView;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /* wait a beat before animating in */
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.splashView startAnimation];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
