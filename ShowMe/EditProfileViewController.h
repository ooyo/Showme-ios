//
//  EditProfileViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 11/13/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
#import <TPKeyboardAvoidingScrollView.h>
#import "GlobalVariables.h"
#import "RemoteImageHandler.h"
#import <TSMessage.h>
#import <TSMessageView.h>
@interface EditProfileViewController : UIViewController <UIGestureRecognizerDelegate,TSMessageViewProtocol, NSURLSessionDelegate>{
 int selectedIndex;
    NSUserDefaults *defaults;
      NSDictionary *dictionary;
    NSMutableData *receivedData;
}
- (IBAction)btnActionBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet TextFieldValidator *userName;
@property (weak, nonatomic) IBOutlet TextFieldValidator *userAge;
@property (weak, nonatomic) IBOutlet UISegmentedControl *userGender;
@property (weak, nonatomic) IBOutlet UITextField *userEmail;
- (IBAction)submitBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *userImageBG;
- (IBAction)selectedType:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmit;
@end
