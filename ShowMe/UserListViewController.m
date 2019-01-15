//
//  UserListViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserListViewController.h"

@interface UserListViewController ()

@end

@implementation UserListViewController
@synthesize selectedUserID;
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self sendHTTPPost];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserListTableCell" bundle:nil] forCellReuseIdentifier:@"UserListTableCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Refreshing data…"
                                                                attributes: @{NSForegroundColorAttributeName:[UIColor grayColor]}];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithAttributedString:title];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];

}

-(void)refreshView: (UIRefreshControl *) refresh{
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sendHTTPPost];
        [refresh endRefreshing];
    });
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
    
    return 70.f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserListTableCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"UserListTableCell"];
    
    NSString *userInfoLabel= [NSString stringWithFormat:@"<b>%@</b> events / <b>%@</b> followers", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"eventCount"],[[userListArray objectAtIndex:indexPath.row] objectForKey:@"followersCount"]];
    
    [cell.cellUserInfo rc_setTaggedText:userInfoLabel];

    cell.cellUserName.text = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"name"];
  /*  NSString *imageHTML = [NSString stringWithFormat:
                           @"<html>"
                           "<head>"
                           "<script type=\"text/javascript\" >"
                           "function display(img){"
                           "var imgOrigH = document.getElementById('image').offsetHeight;"
                           "var imgOrigW = document.getElementById('image').offsetWidth;"
                           "var bodyH = window.innerHeight;"
                           "var bodyW = window.innerWidth;"
                           "if((imgOrigW/imgOrigH) > (bodyW/bodyH))"
                           "{"
                           "document.getElementById('image').style.width = bodyW + 'px';"
                           "document.getElementById('image').style.top = (bodyH - document.getElementById('image').offsetHeight)/2  + 'px';"
                           "}"
                           "else"
                           "{"
                           "document.getElementById('image').style.height = bodyH + 'px';"
                           "document.getElementById('image').style.marginLeft = (bodyW - document.getElementById('image').offsetWidth)/2  + 'px';"
                           "}"
                           "}"
                           "</script>"
                           "<meta name=\"viewport\" content=\"width=device-width,minimum-scale=1.0, maximum-scale=1.0\" />"
                           "</head>"
                           "<body style=\"margin:0;width:100%%;height:100%%;\" >"
                           "<img id=\"image\" src=\"%@\" onload=\"display()\" style=\"position:relative; width:100%%; height:100%%;\" />"
                           "</body>"
                           "</html>", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]
                           ];
    
    [cell.cellUserImage loadHTMLString:imageHTML baseURL:nil];
    [cell.cellUserImage setScalesPageToFit:YES];
    
    */
    
    NSURL *imagePathFull =[NSURL URLWithString:[[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]];
    
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
       
            [cell.cellUserImage1 setImage:image];
        
    }];

    
    [cell.userFollow setTitle:@"Following" forState:UIControlStateNormal];
    [cell.userFollow setBackgroundColor:colorLightBlue];
    [cell.userFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    cell.buttonUserFollowTapAction = ^(id sender){
        
        @try {
            
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURL *url = [NSURL URLWithString:eventUserFollowUserURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:60.0];
            
            [request setHTTPMethod:@"POST"];
            
            defaults = [NSUserDefaults standardUserDefaults];
            if(!selectedUserID){
                selectedUserID = [defaults objectForKey:@"userid"];
            }
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userid\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[selectedUserID dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"follower_id\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"] dataUsingEncoding:NSUTF8StringEncoding]];
            UIButton *btnFollow = (UIButton*)sender;
            [request setHTTPBody:body];
            NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if([[dictionary objectForKey:@"result"] isEqualToString:@"following"]){
                            [btnFollow setTitle:@"Following" forState:UIControlStateNormal];
                            [btnFollow setBackgroundColor:colorLightBlue];
                            [btnFollow setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                        }else{
                            [btnFollow setTitle:@"Follow" forState:UIControlStateNormal];
                            [btnFollow setBackgroundColor:[UIColor whiteColor]];
                            [btnFollow setTitleColor:colorLightBlue forState:UIControlStateNormal];
                        }
                        [tableView reloadData];
                    });
                    
                }
            }];
            [postDataTask resume];
            
        }
        @catch (NSException * e) {
            
        }
        
    };
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    selectedUserID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OtherUserProfileViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherUserProfile"];
    smallViewController.selectedUserID = selectedUserID;
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(screenSize.width -16 , screenSize.height - 100)];
    [self presentViewController:popupViewController animated:NO completion:nil];
}
/* ============= Table End ======================= */
/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:profileFollowURL];
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    if(!selectedUserID){
        selectedUserID = [defaults objectForKey:@"userid"];
    }
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
            userListArray = [[[dictionary objectForKey:@"result"] objectForKey:@"following"]mutableCopy];
            [self.tableView reloadData];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */


@end
