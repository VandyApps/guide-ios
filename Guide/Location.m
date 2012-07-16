//
//  Location.m
//  MobileTourGuide
//
//  Created by Scott Andrus on 2/21/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "Location.h"

@implementation Location

@synthesize name = _name;
@synthesize imagePath = _imagePath;
@synthesize placeDescription = _placeDescription;
@synthesize videoPath = _videoPath;
@synthesize category = _category;
@synthesize hours = _hours;
@synthesize onAgenda;

- (id)init {
    self = [super init];
    if (self) {
        onAgenda = NO;
    }
    return self;
}

- (id)initWithName:(NSString *)aName
       description:(NSString *)aDescription
         imagePath:(NSString *)anImagePath
             video:(NSString *)aVideoPath
          category:(NSString *)aCategory
             hours:(NSString *)someHours
          onAgenda:(BOOL)isOnAgenda{
    self = [super init];
    if (self) {
        self.name = aName;
        self.placeDescription = aDescription;
        self.imagePath = anImagePath;
        self.videoPath = aVideoPath;
        self.category = aCategory;
        self.hours = someHours;
        self.onAgenda = isOnAgenda;
    }
    return self;
}

@end
