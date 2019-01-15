//
//  HomeUserListViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 7/7/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserListTableCell.h"
#import "GlobalVariables.h"
#import "RCTagProcessor.h"
#import "UILabel+TextAttributeTags.h"
#import "RemoteImageHandler.h"
@interface HomeUserListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>
{
 
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSUserDefaults *defaults;
    NSMutableData *receivedData;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)btnExit:(id)sender;
@property (strong, nonatomic) NSString *selectedEvent;
@end
