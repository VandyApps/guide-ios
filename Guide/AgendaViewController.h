//
//  AgendaViewController.h
//  Guide
//
//  Created by Scott Andrus on 6/12/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Location.h"

@interface AgendaViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray *agenda;
@property (strong, nonatomic) NSDictionary *allLocations;
@property (strong, nonatomic) NSOrderedSet *categories;
@property (strong, nonatomic) UIImageView *imageView;

@end
