//
//  AppDelegate.h
//  ShowMe
//
//  Created by Nuk3denE on 3/9/16.
//  Copyright © 2016 Mongol Media Solution LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h> 

#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{ 
}

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

