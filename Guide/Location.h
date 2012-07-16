//
//  Location.h
//  MobileTourGuide
//
//  Created by Scott Andrus on 2/21/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSManagedObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imagePath;
@property (strong, nonatomic) NSString *placeDescription;
@property (strong, nonatomic) NSString *videoPath;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *hours;
@property BOOL onAgenda;


@end
