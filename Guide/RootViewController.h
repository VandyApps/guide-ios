//
//  RootViewController.h
//  Guide
//
//  Created by Scott Andrus on 6/16/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZXingWidgetController.h>
#import "Location.h"

@interface RootViewController : UITabBarController <ZXingDelegate>

@property (strong, nonatomic) NSDictionary *locationDictionary;
@property (strong, nonatomic) Location *currentScan;

@end
