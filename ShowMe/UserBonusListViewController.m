//
//  UserBonusListViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "UserBonusListViewController.h"

@interface UserBonusListViewController ()

@end

@implementation UserBonusListViewController
@synthesize selectedUserID;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self sendHTTPPost];
    [self.tableView registerNib:[UINib nibWithNibName:@"CouponCell" bundle:nil] forCellReuseIdentifier:@"CouponCell"];
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
    
    return 230.f;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [userListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CouponCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"CouponCell"];
    
    [cell.bonusPlace setText:[[userListArray objectAtIndex:indexPath.row] objectForKey:@"bonus_place"]];
    
    cell.bonusDescription.text = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"bonus_description"];
    if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Activity"]){
        [cell.bonusBG setBackgroundColor:categoryActivity];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Coffee Shop"]){
        [cell.bonusBG setBackgroundColor:categoryCoffee];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Lounge"]){
        [cell.bonusBG setBackgroundColor:categoryLounge];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Mall"]){
        [cell.bonusBG setBackgroundColor:categoryMall];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Night Club"]){
        [cell.bonusBG setBackgroundColor:categoryNight];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Pub"]){
        [cell.bonusBG setBackgroundColor:categoryPub];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Restaurant"]){
        [cell.bonusBG setBackgroundColor:categoryRestaurant];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Shop"]){
        [cell.bonusBG setBackgroundColor:categoryShop];
    }else if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"] isEqualToString:@"Theatre"]){
        [cell.bonusBG setBackgroundColor:categoryTheatre];
    }else{
        [cell.bonusBG setBackgroundColor:categoryActivity];
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    selectedUserID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OtherEventViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"OtherEventProfile"];
    
    smallViewController.selectedEventID = [[userListArray objectAtIndex:indexPath.row] objectForKey:@"event"];
    smallViewController.selectedCategory =[[userListArray objectAtIndex:indexPath.row] objectForKey:@"category"];
    if([[[userListArray objectAtIndex:indexPath.row] objectForKey:@"event"] isEqualToString:@"none"]){
         [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else{
        CGRect screenBound = [[UIScreen mainScreen] bounds];
        CGSize screenSize = screenBound.size;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(screenSize.width -16 , screenSize.height - 100)];
        [self presentViewController:popupViewController animated:NO completion:nil];
    }
}
/* ============= Table End ======================= */
/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:profileBonusURL];
    
    defaults = [NSUserDefaults standardUserDefaults];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    NSLog(@"User id:%@", [defaults objectForKey:@"userid"]);
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
            userListArray = [[[dictionary objectForKey:@"result"] objectForKey:@"bonus"] mutableCopy];
            [self.tableView reloadData];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */


@end
