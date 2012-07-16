//
//  MapViewController.m
//  Guide
//
//  Created by Scott Andrus on 6/30/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "MapViewController.h"
#import "Location.h"
#import "LocationDetailViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView.delegate = self;
    
    // 1
    CLLocationCoordinate2D zoomLocation;
    [self.mapView setShowsUserLocation:YES];
    zoomLocation.latitude = 36.143566;
    zoomLocation.longitude= -86.805906;

    // 2
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
    // 3
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    // 4
    [self.mapView setRegion:adjustedRegion animated:YES];
    if (self.mapView.showsUserLocation) {
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow];
    }
}

//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    // 1
//    CLLocationCoordinate2D zoomLocation;
//    zoomLocation = userLocation.location.coordinate;
//    
//    // 2
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 0.5*METERS_PER_MILE, 0.5*METERS_PER_MILE);
//    // 3
//    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:viewRegion];
//    // 4
//    [mapView setRegion:adjustedRegion animated:YES];
//}

- (void)viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"scanLoc"]) {
        LocationDetailViewController *destination = segue.destinationViewController;
        Location *location = sender;
        destination.title = location.name;
        
        destination.location = location;
    }
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
@end
