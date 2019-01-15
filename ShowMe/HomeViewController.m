//
//  HomeViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/10/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
    recipePhotos = [NSArray arrayWithObjects:@"cat_activity", @"cat_pub", @"cat_restaurant", @"cat_night", @"cat_coffee", @"cat_mall", nil];
    [self sendHTTPPost];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"Refreshing data…"
                                                                attributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithAttributedString:title];
    [refreshControl addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView insertSubview:refreshControl atIndex:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CardTableCell" bundle:nil] forCellReuseIdentifier:kBookCellIdentifier];
    self.tableView.estimatedRowHeight = 200.f;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}


-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}

-(void)refreshView: (UIRefreshControl *) refresh{
    double delayInSeconds = 2;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self sendHTTPPost];
        [refresh endRefreshing];
    });
}


-(void) settingSlide{
    
     //
    NSMutableArray *slideSet = [[NSMutableArray alloc] init];
    JOLImageSlide *slide[[topEventListArray count]];
    for(int i = 0; i < [topEventListArray count]; i++){
        if([[[topEventListArray objectAtIndex:i] objectForKey:@"contentType"] isEqualToString:@"event"]){
            slide[i] = [[JOLImageSlide alloc] init];
            slide[i].title =[NSString stringWithFormat:@"%@",[[topEventListArray objectAtIndex:i] objectForKey:@"title"]];
            slide[i].image = [NSString stringWithFormat:@"%@%@", eventsImagePath, [[topEventListArray objectAtIndex:i] objectForKey:@"imagepath"]];
            if([[topEventListArray objectAtIndex:i] objectForKey:@"place"]){
                slide[i].subTitle = [NSString stringWithFormat:@"@ %@ ", [[[topEventListArray objectAtIndex:i] objectForKey:@"place"] objectForKey:@"place_name"]];
            }else{
                slide[i].subTitle = @"ShowMe Sponsored Event";
            }
        }else{
            slide[i] = [[JOLImageSlide alloc] init];
            slide[i].title =[NSString stringWithFormat:@"%@",[[topEventListArray objectAtIndex:i] objectForKey:@"name"]];
            slide[i].image = [NSString stringWithFormat:@"%@%@", advertisePathURL, [[topEventListArray objectAtIndex:i] objectForKey:@"image"]];
            slide[i].subTitle = [NSString stringWithFormat:@"%@",[[topEventListArray objectAtIndex:i] objectForKey:@"slogan"]];
            
        }
        
        [slideSet addObject:slide[i]];
    }
    
    JOLImageSlider *imageSlider = [[JOLImageSlider alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width+5, 145) andSlides: slideSet];
    if([[[topEventListArray objectAtIndex:0] objectForKey:@"expire"] intValue] > 365){
        //safe
        [imageSlider setSubtitleColor:[UIColor colorWithRed:38.f/255.f green:156.f/255.f blue:187.f/255.f alpha:1.0]];
    }else if([[[topEventListArray objectAtIndex:0] objectForKey:@"expire"] intValue] < 30){
        //unsafe
        [imageSlider setSubtitleColor:[UIColor colorWithRed:255.f/255.f green:206.f/255.f blue:0.f/255.f alpha:1.0]];
    }else{
        //default
        [imageSlider setSubtitleColor:[UIColor colorWithRed:202.f/255.f green:202.f/255.f blue:0.f/202.f alpha:1.0]];
    }
    imageSlider.delegate = self;
    [imageSlider setAutoSlide: YES];
    [imageSlider setPlaceholderImage:@"noimage"];
    [imageSlider setContentMode: UIViewContentModeScaleToFill];
    [self.mainSlide addSubview: imageSlider];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
/* ============= Collection Start ================ */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipePhotos.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectionCell";
    HomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.categoryImage.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectionCell";
    HomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float cellWidth = collectionView.frame.size.width / 3 - 12;
    float cellHeight = cellWidth;
    return CGSizeMake(cellWidth, cellHeight);
}
/* ============= Collection End ================== */

/* ============= Table Start ===================== */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"home_to_detail_segue" sender:self];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [allEventListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CardTableCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:kBookCellIdentifier];
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
                           "</html>",eventsImagePath, [[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"imagepath"]
                           ];
    [cell.cardImageWebView loadHTMLString:imageHTML baseURL:nil];
    [cell.cardImageWebView setScalesPageToFit:YES];
    [cell.cardCategoryImage setImage:[UIImage imageNamed:[RoundCardImage imageName:[NSString stringWithFormat:@"%@",[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"category"]]]]];
    [cell.cardLikeLabel setText:[NSString stringWithFormat:@"%@",[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"like"]]];
    
    if([[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"]){
        for(int i = 0; i< [[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] count]; i++){
            
            NSURL *imagePathFull =[NSURL URLWithString:[[[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"goingUserImage"] objectAtIndex:i] objectForKey:@"user"]];
            
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

    if([[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"isGoing"] isEqualToString:@"1"]){
        [cell.cardBadge setImage:[UIImage imageNamed:@"going_mark"]];
    }else if([[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"isInterested"] intValue] == 1){
        [cell.cardBadge setImage:[UIImage imageNamed:@"interested_mark"]];
    }else{
        [cell.cardBadge setImage:[UIImage imageNamed:@""]];
    }
    cell.buttonUserTapAction = ^(id sender){
        selectedEventID = [[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        HomeUserListViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"homeUserListVC"];
        smallViewController.selectedEvent = selectedEventID;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(350, 400)];
        [self presentViewController:popupViewController animated:NO completion:nil];
    };
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:28800]];
    NSString *stringDate = [NSString stringWithFormat:@"%@:00",[[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"end_time"]];
    NSDate *currentDate = [dateFormatter dateFromString:stringDate];
    NSTimeInterval interval = [currentDate timeIntervalSince1970];
    int timeAgo =[self stringForTimeIntervalSinceCreated:&interval];
    cell.cardTimeLabel.text = [self formatTimeFromSeconds:timeAgo];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)settinCell: (CardTableCell *) setCell cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    setCell.cartTitle.text = [[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"title"];
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
        if (hours) {
            return [NSString stringWithFormat:@"%d hour", hours];
        }
        if (minutes) {
            return [NSString stringWithFormat:@"%d min", minutes];
        }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) imagePager:(JOLImageSlider *)imagePager didSelectImageAtIndex:(NSUInteger)index {
    slideSelectedIndex = index;
    if([[[topEventListArray objectAtIndex:index] objectForKey:@"contentType"] isEqualToString:@"advertise"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[topEventListArray objectAtIndex:index] objectForKey:@"connect"]]]];
    }else{
        [self performSegueWithIdentifier:@"homeslide_to_detail" sender:self];
    }
    
}
/* ================ Connection handler ================= */
 -(void)sendHTTPPost{
     dispatch_async(dispatch_get_main_queue(), ^{
         [self progressShow];
     });
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:homeURL];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:100.0];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[defaults objectForKey:@"userid"], @"userid", [defaults objectForKey:@"notif"], @"notif", nil];
     NSLog(@"Notif date :%@",[defaults objectForKey:@"notif"] );
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
     [urlRequest setHTTPMethod:@"POST"];
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
        NSError *error;
        dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options: NSJSONReadingMutableContainers error: &error];
        
    
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            topEventListArray = [[[dictionary objectForKey:@"result"] objectForKey:@"top"] mutableCopy];
            allEventListArray = [[[dictionary objectForKey:@"result"] objectForKey:@"active"]mutableCopy];
            [defaults setObject:[[dictionary objectForKey:@"result"] objectForKey:@"notif"] forKey:@"notif_count"];
            
            [defaults synchronize];
            [self settingSlide];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        } else{
            NSString *errorMessage = [NSString stringWithFormat:@"Алдаа! %@", [dictionary objectForKey:@"result"]];
            [TSMessage showNotificationWithTitle:@"Loading Failed!"
                                        subtitle:errorMessage
                                            type:TSMessageNotificationTypeError];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
            
        }
    }
    else
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
}


- (NSString *)stringByRemovingControlCharacters: (NSString *)inputString
{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];
    NSRange range = [inputString rangeOfCharacterFromSet:controlChars];
    if (range.location != NSNotFound) {
        NSMutableString *mutable = [NSMutableString stringWithString:inputString];
        while (range.location != NSNotFound) {
            [mutable deleteCharactersInRange:range];
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return inputString;
}



/* ============= Connection End =================== */



/* ============= Prepare Segue ================= */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"home_category"]) {
          NSIndexPath *indexPath2= [[self.collectionView indexPathsForSelectedItems] lastObject];
        CategoryListTable *destViewController = segue.destinationViewController;
        if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_activity"]){
            destViewController.selectedCategory =@"Activity";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_coffee"]){
            destViewController.selectedCategory =@"Coffee Shop";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_lounge"]){
            destViewController.selectedCategory =@"Lounge";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_mall"]){
            destViewController.selectedCategory =@"Mall";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_night"]){
            destViewController.selectedCategory =@"Night Club";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_pub"]){
            destViewController.selectedCategory =@"Pub";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_restaurant"]){
            destViewController.selectedCategory =@"Restaurant";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_shop"]){
            destViewController.selectedCategory =@"Shop";
        }else if([[recipePhotos objectAtIndex:indexPath2.row] isEqualToString:@"cat_theatre"]){
            destViewController.selectedCategory =@"Theatre";
        }else{
            destViewController.selectedCategory =@"Activity";
        }
    }else if([segue.identifier isEqualToString:@"home_to_detail_segue"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        EventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.selectedEventID = [[allEventListArray objectAtIndex:indexPath.row] objectForKey:@"_id"];
        eventDetailController.selectedCategory =@"default";
    }else if([segue.identifier isEqualToString:@"homeslide_to_detail"]){
        EventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.selectedEventID = [[topEventListArray objectAtIndex:slideSelectedIndex] objectForKey:@"_id"];
        eventDetailController.selectedCategory =@"default";
    }
}

@end
