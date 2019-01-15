//
//  UserNotificationViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 11/3/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserNotificationViewController.h"

@interface UserNotificationViewController ()

@end

@implementation UserNotificationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self sendHTTPPost];
    [self.tableView registerNib:[UINib nibWithNibName:@"UserNotificationTableViewCell" bundle:nil] forCellReuseIdentifier:@"UserNotificationTableViewCell"];
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
    
    return 60.f;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UserNotificationTableViewCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"UserNotificationTableViewCell"];
    
    if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"user"]){
        NSString *userImagePath = [NSString stringWithFormat:@"%@", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]];
        [cell.userNotifImage loadHTMLString:[self userImageSetter:userImagePath] baseURL:nil];
        [cell.userNotifImage setScalesPageToFit:YES];
        NSString *message = [NSString stringWithFormat:@"%@%@",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"name"], [[userListArray objectAtIndex:indexPath.row] objectForKey:@"message"]];
        [cell.userNotifText setText:message];
        
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"place"]){
        NSString *userImagePath = [NSString stringWithFormat:@"%@", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]];
        [cell.userNotifImage loadHTMLString:[self placeImagePathSetter:userImagePath] baseURL:nil];
        [cell.userNotifImage setScalesPageToFit:YES];
        NSString *message = [NSString stringWithFormat:@"%@%@",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"name"], [[userListArray objectAtIndex:indexPath.row] objectForKey:@"message"]];
        [cell.userNotifText setText:message];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"event"]){
        NSString *userImagePath = [NSString stringWithFormat:@"%@", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]];
        [cell.userNotifImage loadHTMLString:[self eventImagePathSetter:userImagePath] baseURL:nil];
        [cell.userNotifImage setScalesPageToFit:YES];
        NSString *message = [NSString stringWithFormat:@"%@%@",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"name"], [[userListArray objectAtIndex:indexPath.row] objectForKey:@"message"]];
        [cell.userNotifText setText:message];
    }else{
        NSString *userImagePath = [NSString stringWithFormat:@"%@", [[userListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]];
        [cell.userNotifImage loadHTMLString:[self userImageSetter:userImagePath] baseURL:nil];
        [cell.userNotifImage setScalesPageToFit:YES];
        
        [cell.userNotifText setText:[[userListArray objectAtIndex:indexPath.row] objectForKey:@"message"]];
    }
    
  
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(NSString *) eventImagePathSetter: (NSString *) path{

    NSString *imageHTML = [NSString stringWithFormat:
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
                           "<img id=\"image\" src=\"%@%@\" onload=\"display()\" style=\"position:relative; width:100%%; height:100%%;\" />"
                           "</body>"
                           "</html>",eventsImagePath, path
                           ];
    return  imageHTML;
}

-(NSString *) userImageSetter: (NSString *) path{
    
    NSString *imageHTML = [NSString stringWithFormat:
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
                           "</html>", path
                           ];
    return  imageHTML;
}

-(NSString *) placeImagePathSetter: (NSString *) path{
    
    NSString *imageHTML = [NSString stringWithFormat:
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
                           "<img id=\"image\" src=\"%@%@\" onload=\"display()\" style=\"position:relative; width:100%%; height:100%%;\" />"
                           "</body>"
                           "</html>",placeImagePath, path
                           ];
    return  imageHTML;
}

/* ============= Table End ======================= */
/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:profileNotifListURL];
    
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

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"type"] isEqualToString:@"event"]){
        selectedUserID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OtherEventViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherEventProfile"];
        
        smallViewController.selectedEventID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"event_id"];
        smallViewController.selectedCategory =@"";
        
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(screenSize.width -16 , screenSize.height - 100)];
        [self presentViewController:popupViewController animated:NO completion:nil];
        
    }
    
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
        NSLog(@"Notification list %@",  dictionary);
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            userListArray = [[dictionary objectForKey:@"result"]mutableCopy];
            [self.tableView reloadData];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */

@end
