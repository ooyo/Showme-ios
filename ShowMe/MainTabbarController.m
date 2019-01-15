//
//  MainTabbarController.m
//  ShowMe
//
//  Created by Nuk3denE on 6/29/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "MainTabbarController.h"

@interface MainTabbarController ()

@end

@implementation MainTabbarController
- (void)viewDidLoad {
    [super viewDidLoad];
     //UITabBarController *tabBarController = [self tabBarController].tabBar;
    //UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UITabBar *tabBar = [self tabBarController].tabBar;
    UITabBarItem *tabBarItem1 = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItem2 = [tabBar.items objectAtIndex:1];
    UITabBarItem *tabBarItem3 = [tabBar.items objectAtIndex:2];
    UITabBarItem *tabBarItem4 = [tabBar.items objectAtIndex:3];
    
    
    tabBarItem1.title = @"Home";
    tabBarItem2.title = @"Category";
    tabBarItem3.title = @"Pin";
    tabBarItem4.title = @"Profile";
    
    
    [tabBarItem1 setImage:[[UIImage imageNamed:@"tab_home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem1 setSelectedImage:[[UIImage imageNamed:@"tab_home_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem2 setImage:[[UIImage imageNamed:@"tab_category"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem2 setSelectedImage:[[UIImage imageNamed:@"tab_category_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem3 setImage:[[UIImage imageNamed:@"tab_pin"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem3 setSelectedImage:[[UIImage imageNamed:@"tab_pin_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    [tabBarItem4 setImage:[[UIImage imageNamed:@"tab_profile"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tabBarItem4 setSelectedImage:[[UIImage imageNamed:@"tab_profile_sel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    /*UITabBarController *tabBarController = [[UITabBarController alloc] init];
     //
     
     
     
     [tabBar setBarTintColor:[UIColor clearColor]];
     [tabBar setBackgroundColor:[UIColor clearColor]];
     
     
     [[UITabBar appearance] setSelectionIndicatorImage:[[UIImage imageNamed:@"tab_sel"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)]];
     */
    UIImage* tabBarBackground = [UIImage new];
    [[UITabBar appearance] setBackgroundImage:tabBarBackground];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,
                                                       nil] forState:UIControlStateSelected];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UIView appearanceWhenContainedIn:[UITabBar class], nil] setTintColor:[UIColor whiteColor]];
    
    
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateNormal];
    
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateSelected];
    [UITabBarItem.appearance setTitleTextAttributes:
     @{NSForegroundColorAttributeName : [UIColor whiteColor]}
                                           forState:UIControlStateHighlighted];

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
