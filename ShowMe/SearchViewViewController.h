//
//  SearchViewViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 8/19/16.
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
@interface SearchViewViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate,TSMessageViewProtocol>
{
    
    NSString *selectedEventID;
    NSUserDefaults *defaults;
    NSMutableArray *allEventArray;
    NSDictionary *dictionary;
    NSMutableData *receivedData;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property () SMBInternetConnectionIndicator *internetConnectionIndicator;
@property (nonatomic,assign) BOOL isLoading;
@end
