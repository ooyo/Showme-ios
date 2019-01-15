//
//  AboutShowMeViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 11/14/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "AboutShowMeViewController.h"

@interface AboutShowMeViewController ()

@end

@implementation AboutShowMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendHTTPPost];
    [TSMessage setDelegate:self];
    [TSMessage setDefaultViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSURL * url = [NSURL URLWithString:aboutLink];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
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
            [self.textView setText:[dictionary objectForKey:@"result"]];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
