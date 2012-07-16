//
//  GuideAppDelegate.h
//  Guide
//
//  Created by Scott Andrus on 6/12/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingWidgetController.h>
#import "RootViewController.h"

@interface GuideAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) RootViewController *root;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
