//
//  MapViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/11/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GlobalVariables.h"
#import <JPSThumbnail.h>
#import <MapKit/MapKit.h>
#import <JPSThumbnailAnnotation.h>
#import "MBProgressHUD.h"
#import "RemoteImageHandler.h"
#import "MapViewListViewController.h"
@interface MapViewController : UIViewController  <NSURLSessionDelegate,MBProgressHUDDelegate, MKMapViewDelegate, CLLocationManagerDelegate>{
    NSMutableArray *userListArray;
    NSDictionary *dictionary;
    NSUserDefaults *defaults;
    NSMutableData *receivedData;
    MBProgressHUD *hud;
    NSString *selectedPlaceID;
}
 
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@property(nonatomic, retain) CLLocationManager *locationManager;


@end
