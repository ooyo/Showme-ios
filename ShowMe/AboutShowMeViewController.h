//
//  AboutShowMeViewController.h
//  ShowMe
//
//  Created by Nuk3denE on 11/14/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldValidator.h"
#import <TPKeyboardAvoidingScrollView.h>
#import "GlobalVariables.h"
#import "RemoteImageHandler.h"
#import <TSMessage.h>
#import <TSMessageView.h>
@interface AboutShowMeViewController : UIViewController <UIGestureRecognizerDelegate,TSMessageViewProtocol, NSURLSessionDelegate>{

    NSDictionary *dictionary;
    NSMutableData *receivedData;
}

- (IBAction)backBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
