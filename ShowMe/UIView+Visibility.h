//
//  UIView+Visibility.h
//  ShowMe
//
//  Created by Nuk3denE on 6/21/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Visibility) <CAAnimationDelegate>

- (BOOL)visible;
- (void)setVisible:(BOOL)visible;
- (void)setVisible:(BOOL)visible animated:(BOOL)animated;

@end
