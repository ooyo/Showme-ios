//
//  FacebookLoginViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/27/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "FacebookLoginViewController.h"

@interface FacebookLoginViewController ()

@end

@implementation FacebookLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"User Token : %@",[defaults objectForKey:@"user_token"]);
    if(![[defaults objectForKey:@"walkthrough"] isEqualToString:@"1"]){
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
        [defaults setObject:@"1" forKey:@"walkthrough"];
        [defaults synchronize];
    }
    
    //_loginButton = [[FBSDKLoginButton alloc] init];
   // _loginButton.readPermissions =  @[@"public_profile", @"email",  @"user_about_me", @"user_relationships"];
   
    [TSMessage setDelegate:self];
    [TSMessage setDefaultViewController:self];
    
    [self.loginButton.layer setCornerRadius:5.0f];
    
    
    if([FBSDKAccessToken currentAccessToken]){
        [self.loginButton setTitle:@"Log Out" forState:UIControlStateNormal];
        [self.loginButton addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [_loginButton addTarget:self action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        

    }
}

-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}
-(void)logOut{
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    [FBSDKAccessToken setCurrentAccessToken:nil];
}


-(void)loginButtonClicked
{


    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email",  @"user_about_me", @"user_relationships"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
             [parameters setValue:@"id,email,name,first_name,last_name,age_range,link,gender,picture.width(200).height(200),about,relationship_status" forKey:@"fields"];
             
             
             FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                           initWithGraphPath:@"me"
                                           parameters:parameters
                                           HTTPMethod:@"GET"];
             [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                                   id result,
                                                   NSError *error) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self progressShow];
                 });
                 NSLog(@"Facebook Result: %@", result);
                 @try {
                     
                     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                     NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
                     NSURL *url = [NSURL URLWithString:facebookLogin];
                     NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                            cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                                        timeoutInterval:60.0];
                     
                     [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
                     [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
                     [request setHTTPMethod:@"POST"];
                     
                     NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                     NSDictionary *mapData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                               [result objectForKey:@"email"], @"email",
                                              [[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"], @"picture",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"link"]], @"face_link",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"name"]], @"name",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"id"]],@"fid",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"gender"]], @"gender",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"first_name"]], @"firstname",
                                              [NSString stringWithFormat:@"%@",[result objectForKey:@"last_name"]], @"lastname",
                                              [NSString stringWithFormat:@"%@",[[result objectForKey:@"age_range"] objectForKey:@"min"]], @"age_range",
                                              [defaults objectForKey:@"user_token"], @"device_token", @"appNameIOS", @"user_phone",  nil];
                     
                     NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
                     [request setHTTPBody:postData];
                     
                     NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                         dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                         NSLog(@"Dictionary :%@", dictionary);
                         if (data == nil)
                         {
                             return;
                         }
                         
                         if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSString *errorMessage = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"result"]];
                                 NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                 [defaults setValue:[dictionary objectForKey:@"userid"] forKey:@"userid"];
                                 [defaults setValue:[result objectForKey:@"name"] forKey:@"username"];
                                 [defaults setValue:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"] forKey:@"picture"];
                                 [defaults synchronize];
                                 [TSMessage showNotificationWithTitle:@"Successfully logged in!"
                                                             subtitle:errorMessage
                                                                 type:TSMessageNotificationTypeSuccess];
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [hud hideAnimated:YES];
                                 });
                                 [self performSegueWithIdentifier:@"face_to_main" sender:self];
                             });
                         }else{
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 NSString *errorMessage = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"result"]];
                                 [TSMessage showNotificationWithTitle:@"Failed to Login!"
                                                             subtitle:errorMessage
                                                                 type:TSMessageNotificationTypeError];
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [hud hideAnimated:YES];
                                 });
                             });
                         }
                     }];
                     [postDataTask resume];
                 }
                 @catch (NSException * e) {
                     [TSMessage showNotificationWithTitle:@"Failed!"
                                                 subtitle:[NSString stringWithFormat:@"Error: %@",e]
                                                     type:TSMessageNotificationTypeError];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [hud hideAnimated:YES];
                     });
                 }
             }];
         }
     }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
