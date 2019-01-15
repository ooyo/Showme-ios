//
//  EditProfileViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 11/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self.view layoutIfNeeded];
   
    
    [self.userImage.layer setCornerRadius:self.userImage.frame.size.width/2];
    [self.userImage setClipsToBounds:YES];
    [self.userImageBG.layer setCornerRadius:self.userImageBG.frame.size.width/2];
    [self.userImageBG setClipsToBounds:YES];
    [self.btnSubmit.layer setCornerRadius:5.0];
    [self.userAge setKeyboardType:UIKeyboardTypeNumberPad];
        // Do any additional setup after loading the view.
    [self sendHTTPPost];
    [TSMessage setDelegate:self];
    [TSMessage setDefaultViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnActionBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitBtn:(id)sender {
    if([_userName validate] && [_userAge validate]){
        @try {
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURL *url = [NSURL URLWithString:profileUpdate];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:60.0];
            
            [request setHTTPMethod:@"POST"];
            
            defaults = [NSUserDefaults standardUserDefaults];
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[defaults objectForKey:@"userid"] dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"name\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[self.userName.text dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"age_range\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[self.userAge.text dataUsingEncoding:NSUTF8StringEncoding]];
            
            if(selectedIndex == 0){
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"gender\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"male" dataUsingEncoding:NSUTF8StringEncoding]];
            }else{
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"gender\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"female" dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            [request setHTTPBody:body];
            NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"Dictionary :%@", dictionary);
                if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                    [TSMessage showNotificationWithTitle:@"Success!"
                                                subtitle:[dictionary objectForKey:@"result"]
                                                    type:TSMessageNotificationTypeSuccess];
                       // [self dismissViewControllerAnimated:YES completion:nil];
                    });
                    
                }else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                  
                    
                    [TSMessage showNotificationWithTitle:@"Failed!"
                                                subtitle:[dictionary objectForKey:@"result"]
                                                    type:TSMessageNotificationTypeError];
                        });
                }
            }];
            [postDataTask resume];
            
        }
        @catch (NSException * e) {
            
        }
    }
    
       
}

- (IBAction)selectedType:(id)sender {
    switch ([sender selectedSegmentIndex]) {
        case 0:
            selectedIndex = 0;
            break;
        case 1:
            selectedIndex = 1;
            break;
        default:
            selectedIndex = 0;
            break;
    }
}
        
     /* ============= Connection Start =================== */
-(void)sendHTTPPost{
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
       NSLog(@"%@", dictionary);
       if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
          [self setUserInfo];
       } else{
           [self defaultUserInfo];
       }
   }
   else
       NSLog(@"Error %@",[error userInfo]);
}

-(void)setUserInfo{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@", dictionary);
   [self.userName setText:[[dictionary objectForKey:@"result"] objectForKey:@"name"]];
   
   NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"picture"]]];
   
   [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
       self.userImage.image = image;
   }];
    
    [self.userEmail setText:[[dictionary objectForKey:@"result"] objectForKey:@"email"]];
    [self.userAge setText:[[dictionary objectForKey:@"result"]objectForKey:@"age_range"]];
    
    if([[[dictionary objectForKey:@"result"]objectForKey:@"gender"] isEqualToString:@"male"]){
        [self.userGender setSelectedSegmentIndex:0];
    }else{
        [self.userGender setSelectedSegmentIndex:1];
    }
      });
}
-(void) defaultUserInfo{
   [self.userName setText:@""];
   [self.userEmail setText:@""];
    [self.userAge setText:@""];
}
@end
