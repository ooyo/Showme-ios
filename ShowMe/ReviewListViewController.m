
//
//  ReviewListViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 10/5/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "ReviewListViewController.h"

@interface ReviewListViewController ()

@end

@implementation ReviewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Selected event %@", self.selectedEvent);
    [self sendHTTPPost];
      reviewFont = [UIFont fontWithName:@"Roboto-Light" size:14.0f];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/* ============= Table Start ===================== */

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"user_review"];
    CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                    attributes:@{NSFontAttributeName:reviewFont} context:nil];
    CGSize size =textRect.size;
    if(60 >= size.height){
        return 60;
    }else{
        return size.height + 10;
    }  return 70.f;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EventReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
    
    if(!cell){
        [tableView registerNib:[UINib nibWithNibName:@"EventReviewCell" bundle:nil] forCellReuseIdentifier:@"eventReviewCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
        
    }
    
    [cell.reviewUserName setText:[[userListArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [cell.userReview setText:[[userListArray objectAtIndex:indexPath.row] objectForKey:@"user_review"]];
    
    
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]]];
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
        cell.reviewUserImage.image = image;
    }];
 
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
/* ============= Table End ======================= */
/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:eventReviewListURL];
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:self.selectedEvent, @"eventID", [defaults objectForKey:@"userid"], @"userid", nil];
    
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
        NSLog(@"Dictionary FOllow: %@", dictionary);
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            userListArray = [[dictionary objectForKey:@"result"]mutableCopy];
            NSLog(@"User List Count :%lu", (unsigned long)[userListArray count]);
            [self.tableView reloadData];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */

- (IBAction)btnExit:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)sentReviewAction:(id)sender {
    @try {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
        NSURL *url = [NSURL URLWithString:eventReviewURL];
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
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[defaults objectForKey:@"userid"] dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"eventID\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self.selectedEvent dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"user_review\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[self.reviewTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [request setHTTPBody:body];
        NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"Dictionary :%@", dictionary);
            if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    userListArray = [[dictionary objectForKey:@"result"]mutableCopy];
                    [self.tableView reloadData];
                    
                    [self.reviewTextField setText:@""];
                });
                
            }
        }];
        [postDataTask resume];
        
    }
    @catch (NSException * e) {
        
    }
}
@end
