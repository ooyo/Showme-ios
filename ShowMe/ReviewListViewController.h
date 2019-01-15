//
//  ReviewListViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 10/5/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventReviewCell.h"
#import "GlobalVariables.h"
#import "RCTagProcessor.h"
#import "UILabel+TextAttributeTags.h"

#import "RemoteImageHandler.h"
@interface ReviewListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, NSURLSessionDelegate>

{
    UIFont *reviewFont;
    NSDictionary *dictionary;
    NSMutableArray *userListArray;
    NSUserDefaults *defaults;
    NSMutableData *receivedData;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnExit:(id)sender;
@property (strong, nonatomic) NSString *selectedEvent;
- (IBAction)sentReviewAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *reviewTextField;
@end
