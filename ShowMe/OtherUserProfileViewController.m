//
//  OtherUserProfileViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 10/21/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "OtherUserProfileViewController.h"

@interface OtherUserProfileViewController ()

@end

@implementation OtherUserProfileViewController
@synthesize selectedUserID;
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
    //sampleVC1.view.frame =CGRectMake(0,0, self.tabView.frame.size.width-50, self.tabView.frame.size.height);
    sampleVC1.title = @"list";
    sampleVC1.selectedUserID= selectedUserID;
    
    UserBonusListViewController *sampleVC2 = [[UserBonusListViewController alloc]initWithNibName:@"UserBonusListViewController" bundle:nil];
    sampleVC2.title = @"bonus";
    sampleVC2.selectedUserID= selectedUserID;
    UserEventListViewController *sampleVC3 = [[UserEventListViewController alloc]initWithNibName:@"UserEventListViewController" bundle:nil];
    sampleVC3.title = @"event";
    sampleVC3.selectedUserID= selectedUserID;
    
    
    JPTabViewController *tabViewController = [[JPTabViewController alloc] initWithControllers:@[sampleVC1, sampleVC2, sampleVC3]];

    [self addChildViewController:tabViewController];
    //tabViewController.view.frame = [self frameForContentController];
    tabViewController.view.frame = CGRectMake(0, 0, self.tabView.frame.size.width, self.tabView.frame.size.height);
    [self.tabView addSubview:tabViewController.view];
    // [content didMoveToParentViewController:self];
    
    [self.tabView setUserInteractionEnabled:YES];
    
    
    
    [self.view layoutIfNeeded];
    [self.userImage.layer setCornerRadius:self.userImage.frame.size.width/2];
    [self.userImage setClipsToBounds:YES];
    [self.userImageView.layer setCornerRadius:self.userImageView.frame.size.width/2];
    [self.userImageView setClipsToBounds:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSUserDefaults *selectedUser = [NSUserDefaults standardUserDefaults];
    [selectedUser setValue:selectedUserID forKey:@"selectedUserID"];
    [selectedUser synchronize];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    NSUserDefaults *selectedUser = [NSUserDefaults standardUserDefaults];
    [selectedUser setValue:@"" forKey:@"selectedUserID"];
    [selectedUser synchronize];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    NSUserDefaults *selectedUser = [NSUserDefaults standardUserDefaults];
    [selectedUser setValue:@"" forKey:@"selectedUserID"];
    [selectedUser synchronize];
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
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:selectedUserID, @"userid", nil];
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
-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
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
    [self.userFollow setText:userFollow];
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"picture"]]];
    
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
        self.userImage.image = image;
    }];
}
-(void) defaultUserInfo{
    [self.userName setText:@""];
    
    [self.userFollow setText:@""];
    
}

@end
