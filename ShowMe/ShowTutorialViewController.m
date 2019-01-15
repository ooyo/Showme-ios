//
//  ShowTutorialViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 11/14/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "ShowTutorialViewController.h"

#import "EAIntroView.h"
@interface ShowTutorialViewController () <EAIntroDelegate>

@end

@implementation ShowTutorialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Check in to";
    page1.desc = @"Share and check in to you favorite places that you like to visit";
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"first"]];
    page1.bgColor =[UIColor whiteColor];
    page1.titleIconPositionY = 150.f;
    page1.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page1.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page1.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page1.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"Find New Places";
    page2.desc = @"Find new places and see other user's suggestions";
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"second"]];
    page2.bgColor =[UIColor whiteColor];
    page2.titleIconPositionY = 150.f;
    page2.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page2.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page2.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page2.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Real Bonuses";
    page3.desc = @"Get real bonuses from the places that you love visiting make them care about you";
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"third"]];
    page3.bgColor =[UIColor whiteColor];
    page3.titleIconPositionY = 150.f;
    page3.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page3.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page3.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page3.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Get idolize";
    page4.desc = @"Get followers and follow the other users that you idolize";
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fourth"]];
    page4.bgColor =[UIColor whiteColor];
    page4.titleIconPositionY = 150.f;
    page4.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page4.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page4.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page4.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    
    EAIntroPage *page5 = [EAIntroPage page];
    page5.title = @"Find same interests";
    page5.desc = @"Make new friends with the people that has same interests";
    page5.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fifth"]];
    page5.bgColor =[UIColor whiteColor];
    page5.titleIconPositionY = 150.f;
    page5.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page5.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page5.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page5.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    
    EAIntroPage *page6 = [EAIntroPage page];
    page6.title = @"Get the latest";
    page6.desc = @"Get the latest news directly from the places so you wouldn't miss it";
    page6.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sixth"]];
    page6.bgColor =[UIColor whiteColor];
    page6.titleIconPositionY = 150.f;
    page6.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page6.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page6.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page6.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    
    EAIntroPage *page7 = [EAIntroPage page];
    page7.title = @"Explore the entertainment";
    page7.desc = @"Explore the entertainment world that you don't know";
    page7.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"seventh"]];
    page7.bgColor =[UIColor whiteColor];
    page7.titleIconPositionY = 150.f;
    page7.titleFont = [UIFont fontWithName:@"Roboto-Medium" size:16];
    page7.titleColor = [UIColor colorWithRed:91.f/255.f green:91.f/255.f blue:91.f/255.f alpha:1.0];
    page7.descColor = [UIColor colorWithRed:109.f/255.f green:109.f/255.f blue:109.f/255.f alpha:1.0];
    page7.descFont = [UIFont fontWithName:@"Roboto-Light" size:14];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4,page5,page6,page7]];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
    
    

}
- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
