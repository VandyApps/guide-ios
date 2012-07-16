//
//  MapViewController.h
//  Guide
//
//  Created by Scott Andrus on 6/30/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#define METERS_PER_MILE 1609.344

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
