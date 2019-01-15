//
//  CategoryListTable.h
//  ShowMe
//
//  Created by Nuk3denE on 3/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardTableCell.h"
#import "EventDetailViewController.h"
#import "GlobalVariables.h"
#import "SMBInternetConnectionIndicator.h" 
#import "RoundCardImage.h"
#import <TSMessage.h>
#import <TSMessageView.h>
#import "HomeUserListViewController.h"
@interface CategoryListTable : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate,TSMessageViewProtocol>
{

    NSString *selectedEventID;
    NSUserDefaults *defaults;
    NSMutableArray *allEventArray;
    NSDictionary *dictionary;
    NSMutableData *receivedData;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableHeight;
@property (strong, nonatomic) IBOutlet UIImageView *viewControllerBG;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSString *selectedCategory;

@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@property (nonatomic,assign) BOOL isLoading;
@end
