//
//  MapViewController.m
//  ShowMe
//
//  Created by Nuk3denE on 3/11/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendHTTPPost];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    #ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
            // Use one or the other, not both. Depending on what you put in info.plist
            [self.locationManager requestWhenInUseAuthorization];
                    }
    #endif
    
    [self.mapView setDelegate:self];
}
-(void)progressShow{
    hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Change the background view style and color.
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
}
-(void)viewDidAppear:(BOOL)animated{
    
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    MKCoordinateRegion region = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(_mapView.userLocation.coordinate, 200, 200)];
    [_mapView setRegion:region animated:YES];

    NSLog(@"%@", [self deviceLocation]);
    
}
- (NSString *)deviceLocation {
    return [NSString stringWithFormat:@"latitude: %f longitude: %f", self.locationManager.location.coordinate.latitude, self.locationManager.location.coordinate.longitude];
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(JPSThumbnailAnnotationViewProtocol)]) {
        [((NSObject<JPSThumbnailAnnotationViewProtocol> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(JPSThumbnailAnnotationProtocol)]) {
        return [((NSObject<JPSThumbnailAnnotationProtocol> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* ============= Connection Start =================== */
-(void)sendHTTPPost{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self progressShow];
    });
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    NSError *error1;
    NSURL * url = [NSURL URLWithString:mapListURL];
    
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
            userListArray = [[dictionary objectForKey:@"result"]mutableCopy];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                for(int i=0; i<[userListArray count]; i++){
                    
                        JPSThumbnail *placeLogo[[userListArray count]];
                        placeLogo[i] = [[JPSThumbnail alloc] init];
                        NSURL *imagePathFull =[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",placeImagePath, [[userListArray objectAtIndex:i]  objectForKey:@"image"]]];
                        NSData * data = [[NSData alloc] initWithContentsOfURL:imagePathFull];
                        placeLogo[i].image = [UIImage imageWithData:data];
                        
                        placeLogo[i].title = [[userListArray objectAtIndex:i] objectForKey:@"name"];
                        placeLogo[i].subtitle = [[userListArray objectAtIndex:i] objectForKey:@"slogan"];
                        placeLogo[i].coordinate = CLLocationCoordinate2DMake([[[userListArray objectAtIndex:i] objectForKey:@"latitude"] doubleValue], [[[userListArray objectAtIndex:i] objectForKey:@"longitude"] doubleValue]);
                        //placeLogo[i].coordinate = CLLocationCoordinate2DMake(40.75f, -73.99f);
                        placeLogo[i].disclosureBlock = ^{
                            NSLog(@"Place :%@", [userListArray objectAtIndex:i]);
                            selectedPlaceID = [[userListArray objectAtIndex:i] objectForKey:@"_id"];
                            [self performSegueWithIdentifier:@"place_event_list" sender:self];
                        };
                        
                        
                        placeLogo[i].pinBGColor =[UIColor whiteColor];
                        self.mapView.showsUserLocation=YES;
                        self.mapView.delegate = self;
                        //[self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
                        
                        [self.mapView addAnnotation:[JPSThumbnailAnnotation annotationWithThumbnail:placeLogo[i]]];
                    
                }
                [hud hideAnimated:YES];
                
            });
            [self mapZoomTo:self.mapView byMiles:3.0];
        }
    }
    else
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
        });
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if([segue.identifier isEqualToString:@"place_event_list"]){ 
        MapViewListViewController *eventDetailController = segue.destinationViewController;
         eventDetailController.selectedPlaceID =selectedPlaceID;
         
    }
}


- (void)dealloc
{
#if DEBUG
    // Xcode8/iOS10 MKMapView bug workaround
    static NSMutableArray* unusedObjects;
    if (!unusedObjects)
        unusedObjects = [NSMutableArray new];
    [unusedObjects addObject:_mapView];
#endif
}



-(void)mapZoomTo:(MKMapView *)mapView byMiles:(double)miles{
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    CLLocation *location = [locationManager location];
    CLLocationCoordinate2D coordinate = [location coordinate];
    
    if( (int) mapView.userLocation.coordinate.latitude < 0  || (int) mapView.userLocation.coordinate.latitude == 0 ){
        coordinate.latitude =47.918873;
        coordinate.longitude =106.917057;
        
        double scalingFactor = ABS( (cos(2 * M_PI * coordinate.latitude / 360.0) ));
        MKCoordinateSpan span;
        
        span.latitudeDelta = miles/69.0;
        span.longitudeDelta = miles/(scalingFactor * 69.0);
        MKCoordinateRegion region;
        region.span = span;
        region.center = coordinate;
        [mapView setRegion:region animated:YES];
        NSLog(@"Set Coordinate:%f %f", coordinate.latitude, coordinate.longitude);
    }else{
        
        
        double scalingFactor = ABS( (cos(2 * M_PI * coordinate.latitude / 360.0) ));
        MKCoordinateSpan span;
        
        span.latitudeDelta = miles/69.0;
        span.longitudeDelta = miles/(scalingFactor * 69.0);
        
        MKCoordinateRegion region;
        region.span = span;
        region.center = mapView.userLocation.coordinate;
        [mapView setRegion:region animated:YES];
        NSLog(@"Default Coordinate:%f %f", mapView.userLocation.coordinate.latitude, mapView.userLocation.coordinate.longitude);
    }

}
/* ============= Connection End =================== */


@end
