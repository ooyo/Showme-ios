//
//  EventDetailViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "EventDetailViewController.h"

@interface EventDetailViewController ()

@end

@implementation EventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableView delegate];
    [self.tableView dataSource];
    [self sendHTTPPost];
    NSLog(@"Event ID: %@", _selectedEventID);
    self.navigationController.navigationBar.topItem.title = @" ";
    [self.navigationController setNavigationBarHidden:YES];
    reviewFont = [UIFont fontWithName:@"Roboto-Light" size:14.0f];
    //[self.navigationController popViewControllerAnimated:YES];
}

-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
        [_viewControllerBG setBackgroundColor:colorBlue];
    }
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ================= TableView Start ==================== */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        return 4;
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 1 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        return 5;
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] > 0){
        return 5;
    }else{
        return 6;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
            return 1;
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 1 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        return 1;
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] > 0){
        if(section == 3){
            return [reviewListArray count];
        }else{
            return 1;
        }
    }else{
         if(section == 4){
            return [reviewListArray count];
        }else{
            return 1;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        if(indexPath.section == 0){
            return  140;
        }else if(indexPath.section == 1){
            NSString *str = [[dictionary objectForKey:@"result"] objectForKey:@"description"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
            return size.height + 90;
        }else if(indexPath.section == 2){
            return 170;
        }else{
            return 80;
        }
        return UITableViewAutomaticDimension;
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 1 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        if(indexPath.section == 0){
            return  140;
        }else if(indexPath.section == 1){
            NSString *str = [[dictionary objectForKey:@"result"] objectForKey:@"description"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
            return size.height + 90;
        }else if(indexPath.section == 2){
            return 230;
        }else if(indexPath.section == 3){
            return 170;
        }else{
            return 80;
        }
    }else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] > 0){
        if(indexPath.section == 0){
            return  140;
        }else if(indexPath.section == 1){
            NSString *str = [[dictionary objectForKey:@"result"] objectForKey:@"description"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
             return size.height + 90;

        }else if(indexPath.section == 2){
            return 170;
        }else if(indexPath.section == 3){
            NSString *str = [[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"user_review"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
            if(60 >= size.height){
                return 60;
            }else{
                return size.height + 10;
            }
        }else{
            return 80;
        }
    }else{
        if(indexPath.section == 0){
            return  140;
        }else if(indexPath.section == 1){
            NSString *str = [[dictionary objectForKey:@"result"] objectForKey:@"description"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
          return size.height + 90;

        }else if(indexPath.section == 2){
            return 230;
        }else if(indexPath.section == 3){
            return 170;
        }else if(indexPath.section == 4){
            NSString *str = [[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"user_review"];
            CGRect textRect =[str boundingRectWithSize:CGSizeMake(200, 300) options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:reviewFont} context:nil];
            CGSize size =textRect.size;
            if(60 >= size.height){
                return 60;
            }else{
                return size.height + 10;
            }
            
        }else{
            return 80;
        }
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"eventSlideCell";
    
  
    
    if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        if(indexPath.section == 0){
            EventSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventSlideCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            
            [self eventSlideCellSetting:cell];
           
            return cell;
        }
        else if(indexPath.section == 1){
            EventAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAboutCell" bundle:nil] forCellReuseIdentifier:@"eventAboutCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            }
            [self eventAboutCellSetting:cell];
            return cell;
        }
        else if(indexPath.section == 2){
            EventAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAddressCell" bundle:nil] forCellReuseIdentifier:@"eventAddressCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            }
            [self eventAddressCellSetting:cell];
            return cell;
            
        }
        else{
            EventReviewSendCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewSendCell" bundle:nil] forCellReuseIdentifier:@"eventReviewSendCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            }
       
             [self eventReviewSend:cell];
            return cell;
        }
    }
    else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 1 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] == 0){
        if(indexPath.section == 0){
            EventSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventSlideCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            [self eventSlideCellSetting:cell];
            return cell;
        }
        else if(indexPath.section == 1){
            EventAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAboutCell" bundle:nil] forCellReuseIdentifier:@"eventAboutCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            }
            [self eventAboutCellSetting:cell];
            
            return cell;
        }
        else if(indexPath.section == 2){
            CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCouponCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"CouponCell" bundle:nil] forCellReuseIdentifier:@"eventCouponCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventCouponCell"];
            }
            [self eventCouponCellSetting:cell];
            return cell;
        }
        else if(indexPath.section == 3){
            EventAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAddressCell" bundle:nil] forCellReuseIdentifier:@"eventAddressCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            }
            [self eventAddressCellSetting:cell];
            return cell;
            
        }
        else{
            EventReviewSendCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
           
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewSendCell" bundle:nil] forCellReuseIdentifier:@"eventReviewSendCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            }
       
             [self eventReviewSend:cell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
    else if([[[dictionary objectForKey:@"result"] objectForKey:@"bonusVisible"] integerValue] == 0 && [[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] > 0){
        if(indexPath.section == 0){
            EventSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventSlideCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            [self eventSlideCellSetting:cell];
            
            return cell;
        }
        else if(indexPath.section == 1){
            EventAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAboutCell" bundle:nil] forCellReuseIdentifier:@"eventAboutCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            }
            [self eventAboutCellSetting:cell];
            return cell;
        }
        else if(indexPath.section == 2){
            EventAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAddressCell" bundle:nil] forCellReuseIdentifier:@"eventAddressCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            }
            [self eventAddressCellSetting:cell];
            return cell;
            
        }
        else if(indexPath.section == 3){
            EventReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewCell" bundle:nil] forCellReuseIdentifier:@"eventReviewCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
            }cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [self eventReviewCellSetting:cell reviewlist:indexPath];
            return cell;
        }
        else{
            EventReviewSendCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewSendCell" bundle:nil] forCellReuseIdentifier:@"eventReviewSendCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            }
             [self eventReviewSend:cell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }
    else{
        if(indexPath.section == 0){
            EventSlideCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventSlideCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
                cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
            }
            [self eventSlideCellSetting:cell];
            
            return cell;
        }else if(indexPath.section == 1){
            EventAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAboutCell" bundle:nil] forCellReuseIdentifier:@"eventAboutCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAboutCell"];
            }
            [self eventAboutCellSetting:cell];
            
            return cell;
        }else if(indexPath.section == 2){
            CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCouponCell"];
             if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"CouponCell" bundle:nil] forCellReuseIdentifier:@"eventCouponCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventCouponCell"];
            }
            [self eventCouponCellSetting:cell];
            
            return cell;
        }else if(indexPath.section == 3){
            EventAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
             if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventAddressCell" bundle:nil] forCellReuseIdentifier:@"eventAddressCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventAddressCell"];
            }
            [self eventAddressCellSetting:cell];
            
            return cell;
            
        }else if(indexPath.section == 4){
            EventReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewCell" bundle:nil] forCellReuseIdentifier:@"eventReviewCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewCell"];
            
            }            [self eventReviewCellSetting:cell reviewlist:indexPath];
            
            return cell;
        }else{
            EventReviewSendCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            
            if(!cell){
                [tableView registerNib:[UINib nibWithNibName:@"EventReviewSendCell" bundle:nil] forCellReuseIdentifier:@"eventReviewSendCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"eventReviewSendCell"];
            }           // NSMutableArray *reviewList = [[dictionary objectForKey:@"result"] objectForKey:@"reviews"];
            
          
            
            [self eventReviewSend:cell];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

                       return cell;
        }
    }
        
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0 ){
        MHGalleryItem *image[[idmPhotoArray count]];
        
        NSMutableArray *galleryData = [[NSMutableArray alloc] init];
        
        for(int a=0; a<[idmPhotoArray count]; a++){
            if([[[idmPhotoArray objectAtIndex:a] pathExtension] isEqualToString:@"mp4"] || [[[idmPhotoArray objectAtIndex:a] pathExtension] isEqualToString:@"mov"] ){
                image[a] = [MHGalleryItem itemWithURL:[NSString stringWithFormat:@"%@%@", eventsImagePath,[idmPhotoArray objectAtIndex:a]] galleryType:MHGalleryTypeVideo];
            }else{
                image[a] = [MHGalleryItem itemWithURL:[NSString stringWithFormat:@"%@%@", eventsImagePath,[idmPhotoArray objectAtIndex:a]] galleryType:MHGalleryTypeImage];
            }
            [galleryData addObject:image[a]];
        }
        
        MHGalleryController *gallery = [MHGalleryController galleryWithPresentationStyle:MHGalleryViewModeImageViewerNavigationBarHidden];
        gallery.galleryItems = galleryData;
        gallery.presentationIndex = indexPath.row;
        [gallery.navigationBar setBackgroundColor:[UIColor whiteColor]];
        

        __weak MHGalleryController *blockGallery = gallery;
        
        gallery.finishedCallback = ^(NSInteger currentIndex,UIImage *image,MHTransitionDismissMHGallery *interactiveTransition,MHGalleryViewMode viewMode){
        
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Before dismiss");
                  [blockGallery dismissViewControllerAnimated:YES completion:nil];
            });
        };
        
        [self presentMHGalleryController:gallery animated:YES completion:nil];
        
    
    }
    else{
    }
}

// Setting Table Cells

-(void)eventSlideCellSetting: (EventSlideCell *) eventCell{
    dispatch_async(dispatch_get_main_queue(), ^{
        
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", eventsImagePath, [[dictionary objectForKey:@"result"] objectForKey:@"picture"]]];
    [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
        eventCell.eventMainImage.image = image;
    }];

    if([[[dictionary objectForKey:@"result" ]objectForKey:@"isGoing"] isEqualToString:@"1"]){
        [eventCell.eventGoingBtn.layer setBackgroundColor:colorLightBlue.CGColor];
    }
    
    if([[[dictionary objectForKey:@"result"] objectForKey:@"isInterested"] isEqualToString:@"1"]){
        [eventCell.eventInterestedBtn.layer setBackgroundColor:colorLightBlue.CGColor];
    }
    
    [eventCell.goingCount setTitle:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"goingCount"]] forState:UIControlStateNormal];
    [eventCell.interestCount setTitle:[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"] objectForKey:@"interestCount"]] forState:UIControlStateNormal];
    [eventCell.imageCount setText:[NSString stringWithFormat:@"1/%@", [[dictionary objectForKey:@"result"] objectForKey:@"imageCount"]]];
    [eventCell.slideCellTitle setText:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"title"]]];
    [eventCell.eventAddress setTitle:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"placeAddress"]] forState:UIControlStateNormal];
    [eventCell.eventTime setTitle:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"end_time"]] forState:UIControlStateNormal];
    [eventCell.eventGoingBtn setUserInteractionEnabled:YES];
    
    eventCell.buttonGoingTapAction = ^(id sender) {
        UIButton *goingBtn = (UIButton *)sender;
        @try {
            NSError *error;
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURL *url = [NSURL URLWithString:eventGoingURL];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:60.0];
            
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPMethod:@"POST"];
            NSDictionary *mapData = [[NSDictionary alloc]  initWithObjectsAndKeys:[defaults objectForKey:@"userid"], @"userid", self.selectedEventID, @"eventID", nil];
            
            NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
            [request setHTTPBody:postData];
            
            
            NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                updateDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (data == nil)
                {return;}
                if([[updateDictionary objectForKey:@"resultCode"] isEqualToString:@"0"] && [[updateDictionary objectForKey:@"result"] isEqualToString:@"1"] ){
                    dispatch_async(dispatch_get_main_queue(), ^{
                         //change button
                        [goingBtn.layer setBorderWidth:0.5];
                        [goingBtn.layer setBackgroundColor:colorLightBlue.CGColor];
                    });
                    
                }else if([[updateDictionary objectForKey:@"resultCode"] isEqualToString:@"0"] && [[updateDictionary objectForKey:@"result"] isEqualToString:@"2"] ){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //change button
                        [goingBtn.layer setBorderWidth:0.5];
                        [goingBtn.layer setBackgroundColor:[UIColor clearColor].CGColor];
                    });
                    
                }
            }];
            [postDataTask resume];
            
        }
        @catch (NSException * e) {
            
        }
        
    };
    eventCell.buttonNothingTapAction = ^(id sender){
        
        [self.navigationController setNavigationBarHidden:NO];
       [self.navigationController popViewControllerAnimated:YES];
    };
    
    eventCell.buttonInterestTapAction = ^(id sender) {
        UIButton *interestedBtn = (UIButton *) sender;
        @try {
            NSError *error;
            NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
            NSURL *url = [NSURL URLWithString:eventInterestedURL];
            defaults = [NSUserDefaults standardUserDefaults];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                                   cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                               timeoutInterval:60.0];
            
            [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setHTTPMethod:@"POST"];
            NSDictionary *mapData = [[NSDictionary alloc]  initWithObjectsAndKeys:[defaults objectForKey:@"userid"], @"userid", self.selectedEventID, @"eventID", nil];
            
            NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
            [request setHTTPBody:postData];
            
            
            NSURLSessionDataTask  *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                updateDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (data == nil)
                {return;}
                if([[updateDictionary objectForKey:@"resultCode"] isEqualToString:@"0"]&& [[updateDictionary objectForKey:@"result"] isEqualToString:@"1"] ){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //change button
                        [interestedBtn.layer setBorderWidth:0.5];
                        [interestedBtn.layer setBackgroundColor:colorLightBlue.CGColor];
                    });
                    
                }else if([[updateDictionary objectForKey:@"resultCode"] isEqualToString:@"0"] && [[updateDictionary objectForKey:@"result"] isEqualToString:@"2"] ){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //change button
                        [interestedBtn.layer setBorderWidth:0.5];
                        [interestedBtn.layer setBackgroundColor:[UIColor clearColor].CGColor];
                    });
                    
                }
            }];
            [postDataTask resume];
            
        }
        @catch (NSException * e) {
            
        }
    };
    
    eventCell.buttonShareTapAction = ^(id sender) {
        NSLog(@"Share Tap Action");
    };
    
    
     eventCell.selectionStyle = UITableViewCellSelectionStyleNone;
    });
}
-(void)eventAboutCellSetting: (EventAboutCell *) eventCell{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    [eventCell.eventAboutText setText:[NSString stringWithFormat:@"%@", [[dictionary objectForKey:@"result"] objectForKey:@"description"]]];
    [eventCell.field1Btn setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field1_name"]] forState:UIControlStateNormal];
    [eventCell.field2Btn setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field2_name"]] forState:UIControlStateNormal];
    [eventCell.filed3Btn setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field3_name"]] forState:UIControlStateNormal];
    eventCell.buttonField1TapAction = ^(id sender) {
        UIButton *button = (UIButton *)sender;
        [UIView transitionWithView:button duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [button setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field1_value"]] forState:UIControlStateNormal];
            [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:colorLightBlue];
        } completion:nil];
        
    };
    
    eventCell.buttonField2TapAction = ^(id sender) {
        NSLog(@"Button 2");
        UIButton *button = (UIButton *)sender;
        [UIView transitionWithView:button duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [button setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field2_value"]] forState:UIControlStateNormal];
            [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:colorLightBlue];
        } completion:nil];
        
    };
    
    eventCell.buttonField3TapAction = ^(id sender) {
        UIButton *button = (UIButton *)sender;
        [UIView transitionWithView:button duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
            [button setTitle:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"fields"] objectForKey:@"field3_value"]] forState:UIControlStateNormal];
            [button  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:colorLightBlue];
        } completion:nil];
    };
    
    eventCell.selectionStyle = UITableViewCellSelectionStyleNone;
    });
}
-(void)eventAddressCellSetting: (EventAddressCell *) eventCell{
    NSLog(@"Place: %@", [[dictionary objectForKey:@"result"] objectForKey:@"place"]);
    JPSThumbnail *placeLogo = [[JPSThumbnail alloc] init];
    NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",placeImagePath, [[[dictionary objectForKey:@"result"] objectForKey:@"place"] objectForKey:@"place_logo"]]];
    
    NSData * data = [[NSData alloc] initWithContentsOfURL:imagePathFull];
    placeLogo.image = [UIImage imageWithData:data];
    
    placeLogo.subtitle = [[dictionary objectForKey:@"result"] objectForKey:@"title"];
    placeLogo.coordinate = CLLocationCoordinate2DMake([[[[dictionary objectForKey:@"result"] objectForKey:@"place"] objectForKey:@"place_lat"] doubleValue], [[[[dictionary objectForKey:@"result"] objectForKey:@"place"] objectForKey:@"place_lon"] doubleValue]);
    //placeLogo[i].coordinate = CLLocationCoordinate2DMake(40.75f, -73.99f);
    
    placeLogo.pinBGColor = [UIColor whiteColor];
    
    eventCell.ampView.showsUserLocation=YES;
    eventCell.ampView.delegate = self;
    //[self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    
    [eventCell.ampView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:placeLogo]];
    [self mapZoomTo:eventCell.ampView byMiles:3.0];
}
-(void)mapZoomTo:(MKMapView *)mapView byMiles:(double)miles{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    NSLog(@"User location :%@", location);
    double scalingFactor = ABS( (cos(2 * M_PI * coordinate.latitude / 360.0) ));
    MKCoordinateSpan span;
    
    span.latitudeDelta = miles/69.0;
    span.longitudeDelta = miles/(scalingFactor * 69.0);
    
    MKCoordinateRegion region;
    region.span = span;
    region.center = mapView.userLocation.coordinate;
    [mapView setRegion:region animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
-(void)eventCouponCellSetting: (CouponCell *) eventCell{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    //[eventCell.bonusPlace setText:@"123"];
    [eventCell.bonusPlace setText:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"bonus"] objectForKey:@"name"]]];
    [eventCell.bonusDescription setText:[NSString stringWithFormat:@"%@", [[[dictionary objectForKey:@"result"] objectForKey:@"bonus"] objectForKey:@"description"]]];
         eventCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if([_selectedCategory isEqualToString:@"Activity"]){
        [eventCell.bonusBG setBackgroundColor:categoryActivity];
    }else if([_selectedCategory isEqualToString:@"Coffee Shop"]){
        [eventCell.bonusBG setBackgroundColor:categoryCoffee];
    }else if([_selectedCategory isEqualToString:@"Lounge"]){
        [eventCell.bonusBG setBackgroundColor:categoryLounge];
    }else if([_selectedCategory isEqualToString:@"Mall"]){
        [eventCell.bonusBG setBackgroundColor:categoryMall];
    }else if([_selectedCategory isEqualToString:@"Night Club"]){
        [eventCell.bonusBG setBackgroundColor:categoryNight];
    }else if([_selectedCategory isEqualToString:@"Pub"]){
        [eventCell.bonusBG setBackgroundColor:categoryPub];
    }else if([_selectedCategory isEqualToString:@"Restaurant"]){
        [eventCell.bonusBG setBackgroundColor:categoryRestaurant];
    }else if([_selectedCategory isEqualToString:@"Shop"]){
        [eventCell.bonusBG setBackgroundColor:categoryShop];
    }else if([_selectedCategory isEqualToString:@"Theatre"]){
        [eventCell.bonusBG setBackgroundColor:categoryTheatre];
    }else{
        [eventCell.bonusBG setBackgroundColor:colorBlue];
    }

    });
    
}
-(void)eventReviewCellSetting: (EventReviewCell *) eventCell reviewlist:(NSIndexPath *) indexPath{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    NSString *stringName = [NSString stringWithFormat:@"%@", [[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"name"]];
    NSString *stringReview = [NSString stringWithFormat:@"%@", [[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"user_review"]];
        [eventCell.reviewUserName setText:stringName];
        [eventCell.userReview setText:stringReview];
    
        if([[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]){
            NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[reviewListArray objectAtIndex:indexPath.row] objectForKey:@"picture"]]];
            

            [[RemoteImageHandler shared] imageForUrl:imagePathFull callback:^(UIImage *image) {
                eventCell.reviewUserImage.image = image;
            }];
        }
    
        eventCell.selectionStyle = UITableViewCellSelectionStyleNone;
    });
}
-(void)eventReviewSend:(EventReviewSendCell *) eventCell{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
    if([[[dictionary objectForKey:@"result"] objectForKey:@"reviewCount"] integerValue] <= 10){
         [eventCell.allReviewBtn setHidden:YES];
        //[cell.allReviewBtn setHidden:NO];
        //[cell.allReviewBtn setAlpha:0.0f];
    }else{
         [eventCell.allReviewBtn setHidden:NO];
    }
    
    eventCell.buttonWriteTapAction = ^(id sender) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ReviewListViewController *smallViewController = [storyboard instantiateViewControllerWithIdentifier:@"reviewListVC"];
        smallViewController.selectedEvent = self.selectedEventID;
        BIZPopupViewController *popupViewController = [[BIZPopupViewController alloc] initWithContentViewController:smallViewController contentSize:CGSizeMake(300, 400)];
        [self presentViewController:popupViewController animated:NO completion:nil];
    };
    });
}
-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


/* ================ Connection handler ================= */
-(void)sendHTTPPost{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self progressShow];
        [self.tableView setHidden:YES];
    });
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:eventDetailURL];
    defaults =[NSUserDefaults standardUserDefaults];
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy  timeoutInterval:60.0];
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:_selectedEventID, @"eventID", [defaults objectForKey:@"userid"], @"userid", nil];
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
    [self.tableView setHidden:NO];
    if(error == nil)
    {
        dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        NSLog(@"Dictionary EVENT DETAIL: %@", dictionary);
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            idmPhotoArray = [[[dictionary objectForKey:@"result"] objectForKey:@"idmphoto"] mutableCopy];
            reviewListArray = [[[dictionary objectForKey:@"result"] objectForKey:@"reviews"] mutableCopy];
            [self.tableView reloadData];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
        } else{
//            NSString *errorMessage = [NSString stringWithFormat:@"Алдаа! %@", [dictionary objectForKey:@"result"]];
//             [TSMessage showNotificationWithTitle:@"Loading Failed!"
//                                       subtitle:errorMessage
//                                         type:TSMessageNotificationTypeError];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
            });
            
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}

/* ============= Connection End =================== */
/* ================= TableView End   ==================== */
@end
