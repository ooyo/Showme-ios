//
//  RemoteImageHandler.h
//  ShowMe
//
//  Created by Nuk3denE on 6/26/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoteImageHandler : NSObject

- (void)imageForUrl:(NSURL*)url callback:(void(^)(UIImage *image))callback;

+ (RemoteImageHandler *)shared;

@end