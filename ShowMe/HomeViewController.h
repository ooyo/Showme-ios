//
//  HomeViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 3/10/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCategoryCell.h"
#import "JOLImageSlider.h"
#import "CardTableCell.h"
#import "GlobalVariables.h"
#import "MBProgressHUD.h"
#import <TSMessage.h>
#import <TSMessageView.h>
#import "RoundCardImage.h"
#import "CategoryListTable.h"
#import "EventDetailViewController.h"
#import "SMBInternetConnectionIndicator.h"
#import "HomeUserListViewController.h"
#import "BIZPopupViewController.h"
#import "RemoteImageHandler.h" 

static NSString * const kBookCellIdentifier = @"homeCardTableCell";
@interface HomeViewController : UIViewController <JOLImageSliderDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,MBProgressHUDDelegate, NSURLSessionDelegate, TSMessageViewProtocol>{
    NSDictionary *dictionary;
     MBProgressHUD *hud;
    NSMutableData *allEventData;
    NSMutableArray *allEventListArray;
    NSMutableArray *topEventListArray;
    NSString *selectedAdID;
    NSString *selectedEventID;
    NSUserDefaults *defaults;
    NSString *email;
    NSString *api_token;
    NSString *remember_token;
    NSArray *recipePhotos;
    NSUInteger slideSelectedIndex;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UIScrollView *mainScroll;
@property (strong, nonatomic) IBOutlet UIView *mainSlide;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchButton;
@property (weak) UIViewController *popupController;
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@property (nonatomic,assign) BOOL isLoading;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
