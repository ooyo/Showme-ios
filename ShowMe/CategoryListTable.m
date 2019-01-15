//
//  CategoryListTable.m
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "CategoryListTable.h"

@interface CategoryListTable ()

@end

@implementation CategoryListTable

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CardTableCell" bundle:nil] forCellReuseIdentifier:@"categoryCell"];
    self.tableView.estimatedRowHeight = 200.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    defaults = [NSUserDefaults standardUserDefaults];
      self.navigationItem.title = _selectedCategory;
     [TSMessage setDelegate:self];
    [TSMessage setDefaultViewController:self];
        [self sendHTTPPost];
    
    if([_selectedCategory isEqualToString:@"Activity"]){
        [_viewControllerBG setBackgroundColor:categoryActivity];
    }else if([_selectedCategory isEqualToString:@"Coffee Shop"]){
        [_viewControllerBG setBackgroundColor:categoryCoffee];
    }else if([_selectedCategory isEqualToString:@"Lounge"]){
        [_viewControllerBG setBackgroundColor:categoryLounge];
    }else if([_selectedCategory isEqualToString:@"Mall"]){
        [_viewControllerBG setBackgroundColor:categoryMall];
    }else if([_selectedCategory isEqualToString:@"Night Club"]){
        [_viewControllerBG setBackgroundColor:categoryNight];
    }else if([_selectedCategory isEqualToString:@"Pub"]){
        [_viewControllerBG setBackgroundColor:categoryPub];
    }else if([_selectedCategory isEqualToString:@"Restaurant"]){
        [_viewControllerBG setBackgroundColor:categoryRestaurant];
    }else if([_selectedCategory isEqualToString:@"Shop"]){
        [_viewControllerBG setBackgroundColor:categoryShop];
    }else if([_selectedCategory isEqualToString:@"Theatre"]){
        [_viewControllerBG setBackgroundColor:categoryTheatre];
    }else{
        [_viewControllerBG setBackgroundColor:categoryActivity];
    }
}

- (void)refreshTriggered {
    [self sendHTTPPost];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* ============= Table Start ===================== */


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allEventArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CardTableCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"categoryCell"];
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
                           "</html>",eventsImagePath, [[allEventArray objectAtIndex:indexPath.row] objectForKey:@"imagepath"]
                           ];
    [cell.cardImageWebView loadHTMLString:imageHTML baseURL:nil];
    [cell.cardImageWebView setScalesPageToFit:YES];
    
    [cell.cardCategoryImage setImage:[UIImage imageNamed:[RoundCardImage imageName:[NSString stringWithFormat:@"%@",[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"category"]]]]];
    
    [cell.cardLikeLabel setText:[NSString stringWithFormat:@"%@",[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"like"]]];
    
    
    
    if([[allEventArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"]){
        for(int i = 0; i< [[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] count]; i++){
            
            NSURL *imagePathFull =[NSURL URLWithString:[[[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] objectAtIndex:i] objectForKey:@"user"]];
            
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
    
    
    
    if([[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"isGoing"] isEqualToString:@"1"]){
        [cell.cardBadge setImage:[UIImage imageNamed:@"going_mark"]];
    }else if([[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"isInterested"] intValue] == 1){
        [cell.cardBadge setImage:[UIImage imageNamed:@"interested_mark"]];
    }else{
        [cell.cardBadge setImage:[UIImage imageNamed:@""]];
    }
    cell.buttonUserTapAction = ^(id sender){
        
        selectedEventID = [[allEventArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeUserListViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeUserListVC"];
        smallViewController.selectedEvent = selectedEventID;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(350, 400)];
        [self presentViewController:popupViewController animated:NO completion:nil];
    };
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
    NSString *stringDate = [NSString stringWithFormat:@"%@:00",[[allEventArray objectAtIndex:indexPath.row] objectForKey:@"end_time"]];
    NSDate *currentDate = [dateFormatter dateFromString:stringDate];
    NSTimeInterval interval = [currentDate timeIntervalSince1970];
    int timeAgo =[self stringForTimeIntervalSinceCreated:&interval];
     cell.cardTimeLabel.text = [self formatTimeFromSeconds:timeAgo];
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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

-(void)settinCell: (CardTableCell *) setCell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    setCell.cartTitle.text = [[allEventArray objectAtIndex:indexPath.row] objectForKey:@"title"];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"category_detail" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"category_detail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.selectedEventID = [[allEventArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        eventDetailController.selectedCategory = self.selectedCategory;
    }
}


-(NSDate *)convertStringToDate:(NSString *) date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *nowDate = [[NSDate alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    // NSLog(@"date============================>>>>>>>>>>>>>>> : %@", date);
    date = [date stringByReplacingOccurrencesOfString:@"+0000" withString:@""];
    nowDate = [formatter dateFromString:date];
    // NSLog(@"date============================>>>>>>>>>>>>>>> : %@", nowDate);
    return nowDate;
}

/* ============= Table End ======================= */

/* ================ Connection handler ================= */
- (void)insertRowAtTop {
    __weak typeof(self) weakSelf = self;
    self.isLoading =YES;
    int64_t delayInSeconds = 2.2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        [self sendHTTPPost];
        weakSelf.isLoading =NO;
    });
}
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:categoryURL];
     NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys: [defaults objectForKey:@"userid"], @"userid", _selectedCategory, @"category", nil];
    
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
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error == nil)
    {
        dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            allEventArray = [[dictionary objectForKey:@"result"] mutableCopy];
            
            [self.tableView reloadData];
        } else{
            NSString *errorMessage = [NSString stringWithFormat:@"%@", [dictionary objectForKey:@"result"]];
            [TSMessage showNotificationWithTitle:nil subtitle:errorMessage type:TSMessageNotificationTypeMessage];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */

@end
