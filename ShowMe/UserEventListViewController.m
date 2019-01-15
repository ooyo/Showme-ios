//
//  UserEventListViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserEventListViewController.h"

@interface UserEventListViewController ()

@end

@implementation UserEventListViewController
@synthesize selectedUserID;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self sendHTTPPost];
    [self.tableView registerNib:[UINib nibWithNibName:@"CardTableCell" bundle:nil] forCellReuseIdentifier:@"CardTableCell"];
    self.tableView.estimatedRowHeight = 195.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    defaults = [NSUserDefaults standardUserDefaults];
     
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ============= Table Start ===================== */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CardTableCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"CardTableCell"];
    _tableHeight.constant = tableView.contentSize.height;
    [self settinCell:cell cellForRowAtIndexPath:indexPath];
    
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
                           "</html>",eventsImagePath, [[userListArray objectAtIndex:indexPath.row] objectForKey:@"imagepath"]
                           ];
    [cell.cardImageWebView loadHTMLString:imageHTML baseURL:nil];
    [cell.cardImageWebView setScalesPageToFit:YES];
    
    [cell.cardCategoryImage setImage:[UIImage imageNamed:[RoundCardImage imageName:[NSString stringWithFormat:@"%@",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"]]]]];
    
    [cell.cardLikeLabel setText:[NSString stringWithFormat:@"%@",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"like"]]];
    
    
    
    if([[userListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"]){
        for(int i = 0; i< [[[userListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] count]; i++){
            
            NSURL *imagePathFull =[NSURL URLWithString:[[[[userListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] objectAtIndex:i] objectForKey:@"user"]];
            
            [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
                
                if(i == 0){
                    [cell.cardUserImage0 setImage:image];
                    [cell.cardUserImage1 setHidden:YES];
                    [cell.cardUserImage2 setHidden:YES];
                    [cell.cardUserLabel setHidden:YES];
                }
                
                if(i == 1){
                    [cell.cardUserImage1 setImage:image];
                    [cell.cardUserImage1 setHidden:NO];
                    [cell.cardUserImage2 setHidden:YES];
                    [cell.cardUserLabel setHidden:YES];
                }
                
                if(i == 2){
                    [cell.cardUserImage2 setImage:image];
                    [cell.cardUserImage2 setHidden:NO];
                    [cell.cardUserLabel setHidden:YES];
                }
                
            }];
            
        }
        
    }else{
        [cell.cardUserImage0 setHidden:YES];
        [cell.cardUserImage1 setHidden:YES];
        [cell.cardUserImage2 setHidden:YES];
        [cell.cardUserLabel setHidden:YES];
        [cell.cardUserBtn setHidden:YES];
    }
    
    
    
    if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"isGoing"] isEqualToString:@"1"]){
        [cell.cardBadge setImage:[UIImage imageNamed:@"going_mark"]];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"isInterested"] intValue] == 1){
        [cell.cardBadge setImage:[UIImage imageNamed:@"interested_mark"]];
    }else{
        [cell.cardBadge setImage:[UIImage imageNamed:@""]];
    }
    cell.buttonUserTapAction = ^(id sender){
        
        selectedEventID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeUserListViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeUserListVC"];
        smallViewController.selectedEvent = selectedEventID;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(300, 400)];
        [self presentViewController:popupViewController animated:NO completion:nil];
     
    };
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
    NSString *stringDate = [NSString stringWithFormat:@"%@:00",[[userListArray objectAtIndex:indexPath.row] objectForKey:@"end_time"]];
    NSDate *currentDate = [dateFormatter dateFromString:stringDate];
    NSTimeInterval interval = [currentDate timeIntervalSince1970];
    int timeAgo =[self stringForTimeIntervalSinceCreated:&interval];
     cell.cardTimeLabel.text = [self formatTimeFromSeconds:timeAgo];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    selectedUserID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OtherEventViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherEventProfile"];
    
    smallViewController.selectedEventID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
    smallViewController.selectedCategory =[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"];
    
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(screenSize.width -16 , screenSize.height - 100)];
    [self presentViewController:popupViewController animated:NO completion:nil];

}
-(void)settinCell: (CardTableCell *) setCell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    setCell.cartTitle.text = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"title"];
}

-(NSString *)formatTimeFromSeconds:(int)numberOfSeconds
{
    
    int seconds = numberOfSeconds % 60;
    int minutes = (numberOfSeconds / 60) % 60;
    int hours = numberOfSeconds / 3600;
    int days = numberOfSeconds / 86400;
    
    if(days){
        return [NSString stringWithFormat:@"%d day", POSITIVE(days)];
    }
    //we have >=1 hour => example : 3h:25m
    if (hours) {
        return [NSString stringWithFormat:@"%d hour", hours];
    }
    //we have 0 hours and >=1 minutes => example : 3m:25s
    if (minutes) {
        return [NSString stringWithFormat:@"%d min", minutes];
    }
    //we have only seconds example : 25s
    return [NSString stringWithFormat:@"%d sec", seconds];
}

- (int)stringForTimeIntervalSinceCreated:(NSTimeInterval *)interval
{
    NSTimeInterval timeBetweenThenAndMidnight = [[[NSDate alloc] initWithTimeIntervalSince1970:*interval] timeIntervalSinceDate: [NSDate date]];
     NSDictionary *timeScale = @{@"second":@1,
                                @"minute":@60,
                                @"hour":@3600,
                                @"day":@86400,
                                @"week":@605800,
                                @"month":@2629743,
                                @"year":@31556926};
    NSString *scale;
    int timeAgo = 0- (int)timeBetweenThenAndMidnight;
    if (timeAgo < 60) {
        scale = @"second";
    } else if (timeAgo < 3600) {
        scale = @"minute";
    } else if (timeAgo < 86400) {
        scale = @"hour";
    } else if (timeAgo < 605800) {
        scale = @"day";
    } else if (timeAgo < 2629743) {
        scale = @"week";
    } else if (timeAgo < 31556926) {
        scale = @"month";
    } else {
        scale = @"year";
    }
    
    timeAgo = timeAgo/[[timeScale objectForKey:scale] integerValue];
    NSString *s = @"";
    if (timeAgo > 1) {
        s = @"s";
    }
    
    return  timeAgo;
    
}
/* ============= Table End ======================= */


/* ================ Connection handler ================= */
 -(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
     defaults = [NSUserDefaults standardUserDefaults];
    NSURL * url = [NSURL URLWithString:profileEventURL];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
     if(!selectedUserID)
     {
         selectedUserID = [defaults objectForKey:@"userid"];
     }
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: selectedUserID, @"userid", nil];
    
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
            userListArray = [[dictionary objectForKey:@"result"] mutableCopy];
            [self.tableView reloadData];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */
/* ============= Prepare Segue ================= */

@end
