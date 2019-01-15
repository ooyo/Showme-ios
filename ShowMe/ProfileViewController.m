//
//  ProfileViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self connected]) {
        /* ========== Internet check indicator Begin =================== */
        CGRect screenRect               = CGRectMake(0, 32, [UIScreen mainScreen].bounds.size.width, 24);
        _internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
        [_internetConnectionIndicator setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)];
        [self.navigationController.view addSubview:_internetConnectionIndicator];

        /* ========== Internet check indicator End =================== */
        [self defaultUserInfo];
    }else{
         [self sendHTTPPost];
    }
    /*  ======== Tabpage Begin ========== */
    UserListViewController *sampleVC1 = [[UserListViewController alloc]initWithNibName:@"UserListViewController" bundle:nil];
    sampleVC1.view.frame =CGRectMake(0,0, self.userMainView.frame.size.width, self.userMainView.frame.size.height);
    sampleVC1.title = @"list";
    
    UserBonusListViewController *sampleVC2 = [[UserBonusListViewController alloc]initWithNibName:@"UserBonusListViewController" bundle:nil];
    sampleVC2.title = @"bonus";
    
    UserEventListViewController *sampleVC3 = [[UserEventListViewController alloc]initWithNibName:@"UserEventListViewController" bundle:nil];
    sampleVC3.title = @"event";
    
  
    JPTabViewController *tabViewController = [[JPTabViewController alloc] initWithControllers:@[sampleVC1, sampleVC2, sampleVC3]];
    
    [self addChildViewController:tabViewController];
    tabViewController.view.frame = CGRectMake(0, 0, self.userMainView.frame.size.width, self.userMainView.frame.size.height);
    [self.userMainView addSubview:tabViewController.view];
    
    [self.userMainView setUserInteractionEnabled:YES];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        
        [_userMenu2 addTarget:revealViewController action:@selector(rightRevealToggle:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
    
    [self.view layoutIfNeeded];
    [self.userProfileImage.layer setCornerRadius:self.userProfileImage.frame.size.width/2];
    [self.userProfileImage setClipsToBounds:YES];
    [self.userProfileImageBg.layer setCornerRadius:self.userProfileImageBg.frame.size.width/2];
    [self.userProfileImageBg setClipsToBounds:YES];
    
    
    number = [[MKNumberBadgeView alloc] initWithFrame:CGRectMake(10,-5, 30, 30)];
    if([[defaults objectForKey:@"notif_count"] integerValue] >= 99){
        number.value = 99;
    }else if([[defaults objectForKey:@"notif_count"] integerValue] == 0){
        [number setHideWhenZero:YES];
        [number setHidden:YES];
    }else{
            number.value = [[defaults objectForKey:@"notif_count"] integerValue];
    }
    
    
    [self.userNotifBtn addSubview:number];
    NSLog(@"Badge Number :%@", [defaults objectForKey:@"notif_count"]);
   
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_async(dispatch_get_main_queue(),^{
        if([[defaults objectForKey:@"notif_count"] integerValue] >= 99){
            number.value = 99;
        }else if([[defaults objectForKey:@"notif_count"] integerValue] == 0){
            [number setHideWhenZero:YES];
            [number setHidden:YES];
        }else{
            number.value = [[defaults objectForKey:@"notif_count"] integerValue];
        }
   });
}

-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Will appear");
    defaults = [NSUserDefaults standardUserDefaults];

    if(![defaults objectForKey:@"userid"]){
        [self performSegueWithIdentifier:@"facebook_login_required" sender:self];
    }
}


-(void) willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [_internetConnectionIndicator removeFromSuperview];
    CGRect screenRect               = CGRectMake(0, 0, self.view.bounds.size.width, 64);
    _internetConnectionIndicator    = [[SMBInternetConnectionIndicator alloc] initWithFrame:screenRect];
    [_internetConnectionIndicator setAutoresizingMask:(UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin)];
    [self.view addSubview:_internetConnectionIndicator];
}
//Internet check
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
#pragma mark -- YSLContainerViewControllerDelegate
- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller
{
    [controller viewWillAppear:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self progressShow];
    });
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:profileUserURL];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: [defaults objectForKey:@"userid"], @"userid", nil];
     [urlRequest setHTTPMethod:@"POST"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error1];
    [urlRequest setHTTPBody:postData];
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithRequest:urlRequest];
    [dataTask resume];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    receivedData=nil;
    receivedData=[[NSMutableData alloc] init];
    [receivedData setLength:0];
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
         if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            [self setUserInfo];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [hud hideAnimated:YES];
             });
        } else{
            [self defaultUserInfo];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

-(void)setUserInfo{
    [self.userName setText:[[dictionary objectForKey:@"result"] objectForKey:@"name"]];
    NSString *userFollow = [NSString stringWithFormat:@"%@ followers /%@ following", [[dictionary objectForKey:@"result"] objectForKey:@"followersCount"], [[dictionary objectForKey:@"result"] objectForKey:@"followingCount"]];
    [self.userFollowing setText:userFollow];
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"picture"]]];
    
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
        self.userProfileImage.image = image;
    }];
}
-(void) defaultUserInfo{
    [self.userName setText:@""];
    [self.userFollowing setText:@""];
}
/* ============= Connection End =================== */
- (IBAction)userMenuAction:(id)sender {
  
}
- (IBAction)userNotificationAction:(id)sender {
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    [defaults setObject:dateString forKey:@"notif"];
    [defaults setObject:@"0" forKey:@"notif_count"];
    [defaults synchronize];
    NSLog(@"Notif date: %@ Count :%@", [defaults  objectForKey:@"notif"],[defaults  objectForKey:@"notif_count"]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UserNotificationViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"UserNotificationView"];
    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:smallViewController];
    popover.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 500);
    [number setHideWhenZero:YES];
    [number setHidden:YES];
    popover.arrowDirection = FPPopoverArrowDirectionAny;
    popover.border = NO;
    popover.tint = FPPopoverWhiteTint;
    [popover presentPopoverFromView:sender];
}



@end
