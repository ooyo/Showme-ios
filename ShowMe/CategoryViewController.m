//
//  CategoryViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/12/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    recipePhotos = [NSArray arrayWithObjects:@"cat_activity", @"cat_coffee", @"cat_lounge", @"cat_mall", @"cat_night", @"cat_pub", @"cat_restaurant", @"cat_shop", @"cat_theatre", nil];
    [self sendHTTPPost];
}

-(void) settingSlide{
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
    [self.mainSlider addSubview: imageSlider];
    
}

- (void) imagePager:(JOLImageSlider *)imagePager didSelectImageAtIndex:(NSUInteger)index {
    slideSelectedIndex = index;
    if([[[topEventListArray objectAtIndex:index] objectForKey:@"contentType"] isEqualToString:@"advertise"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [[topEventListArray objectAtIndex:index] objectForKey:@"connect"]]]];
    }else{
       [self performSegueWithIdentifier:@"categoryslide_to_detail" sender:self];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ============= Collection Start ================ */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return recipePhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"collectionCell2";
    
    HomeCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.categoryImage.image = [UIImage imageNamed:[recipePhotos objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    float cellWidth = collectionView.frame.size.width / 3 - 12;
    float cellHeight = cellWidth;
    return CGSizeMake(cellWidth, cellHeight);
}
 -(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"category_list"]) {
            NSIndexPath *indexPath2= [[self.collectionView indexPathsForSelectedItems] lastObject];
        CategoryListTable *destViewController = segue.destinationViewController;
        switch (indexPath2.row) {
            case 0:
                destViewController.selectedCategory =@"Activity";
                break;
            case 1:
                destViewController.selectedCategory =@"Coffee Shop";
                break;
            case 2:
                destViewController.selectedCategory =@"Lounge";
                break;
            case 3:
                destViewController.selectedCategory =@"Mall";
                break;
            case 4:
                destViewController.selectedCategory =@"Night Club";
                break;
            case 5:
                destViewController.selectedCategory =@"Pub";
                break;
            case 6:
                destViewController.selectedCategory =@"Restaurant";
                break;
            case 7:
                destViewController.selectedCategory =@"Shop";
                break;
            case 8:
                destViewController.selectedCategory =@"Theatre";
                break;
            default:
                destViewController.selectedCategory =@"Activity";
                break;
        }
    }else if([segue.identifier isEqualToString:@"categoryslide_to_detail"]){
       
        EventDetailViewController *eventDetailController = segue.destinationViewController;
        eventDetailController.selectedEventID = [[topEventListArray objectAtIndex:slideSelectedIndex] objectForKey:@"_id"];
        eventDetailController.selectedCategory =@"default";
    }
}
/* ============= Collection End ================== */
/* ================ Connection handler ================= */

-(void)sendHTTPPost{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:categoryTopURL];
    defaults = [NSUserDefaults standardUserDefaults];
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
        if([[dictionary objectForKey:@"resultCode"] isEqualToString:@"0"]){
            topEventListArray = [[dictionary objectForKey:@"result"] mutableCopy];
            [self settingSlide];
        } else{
            NSString *errorMessage = [NSString stringWithFormat:@"Error! %@", [dictionary objectForKey:@"result"]];
            [TSMessage showNotificationWithTitle:@"Loading Failed!" subtitle:errorMessage type:TSMessageNotificationTypeWarning];
        }
    }
    else
        NSLog(@"Error %@",[error userInfo]);
}
@end
