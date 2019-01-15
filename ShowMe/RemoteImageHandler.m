//
//  RemoteImageHandler.m
//  ShowMe
//
//  Created by Nuk3denE on 6/26/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import "RemoteImageHandler.h"

@interface RemoteImageHandler ()

@property (nonatomic, strong) NSMutableDictionary *imageDictionary;

@end

@implementation RemoteImageHandler

- (void)imageForUrl:(NSURL*)url callback:(void(^)(UIImage *image))callback {
    if (!!self.imageDictionary[url]) {
        callback(self.imageDictionary[url]);
    } else {
        dispatch_async(dispatch_get_global_queue(0,0), ^{
            NSData * data = [[NSData alloc] initWithContentsOfURL:url];
            if (data == nil)
                callback(nil);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImage *image = [UIImage imageWithData:data];
                self.imageDictionary[url] = image;
                callback(image);
            });
        });
    }
}

+ (RemoteImageHandler *)shared {
    static RemoteImageHandler *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

@end