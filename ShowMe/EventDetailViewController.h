//
//  EventDetailViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventAboutCell.h"
#import "EventSlideCell.h"
#import "EventReviewCell.h"
#import "EventAddressCell.h"
#import "CouponCell.h"
#import "EventAboutCell.h"
#import <IDMPhotoBrowser.h>
#import "EventReviewSendCell.h"
#import "GlobalVariables.h"
#import "MBProgressHUD.h"
#import "RemoteImageHandler.h"
#import <MHGallery.h>
#import <MHOverviewController.h>
#import "ReviewListViewController.h"
#import "BIZPopupViewController.h" 
@interface EventDetailViewController : UIViewController <UITableViewDelegate,MHGalleryDelegate,MBProgressHUDDelegate, UITableViewDataSource, NSURLSessionDelegate, IDMPhotoBrowserDelegate, MKMapViewDelegate, CLLocationManagerDelegate>{
    EventSlideCell *slideCell;
    EventReviewCell *reviewCell;
    EventAddressCell *addressCell; 
   // CouponCell *couponCell;
    NSMutableArray *reviewListArray;
    NSDictionary *dictionary;
    NSMutableArray *idmPhotoArray;
    NSUserDefaults *defaults;
    NSDictionary *updateDictionary;
    UIFont *reviewFont;
    MBProgressHUD *hud;
    NSMutableData *receivedData;
}

@property (weak, nonatomic) IBOutlet UIImageView *viewControllerBG;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *selectedEventID;
@property (strong, nonatomic) NSString *selectedCategory;
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@property(nonatomic, retain) CLLocationManager *locationManager;
@end
