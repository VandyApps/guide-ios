//
//  RootViewController.mm
//  Guide
//
//  Created by Scott Andrus on 6/16/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "RootViewController.h"
#import <QRCodeReader.h>
#import <ZXingWidgetController.h>
#import "ScanViewController.h"
#import "Location.h"
#import "LocationDetailViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize locationDictionary = _locationDictionary;
@synthesize currentScan = _currentScan;

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

#pragma mark - ZXing Delegate methods

- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(NSString *)result {
    
    //self.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self dismissModalViewControllerAnimated:YES];
    
    if ([self.locationDictionary objectForKey:result] != nil) {
        self.currentScan = [self.locationDictionary objectForKey:result];
        UINavigationController *navController = (UINavigationController *)self.selectedViewController;
        [navController.topViewController performSegueWithIdentifier:@"scanLoc" sender:self.currentScan];
    }
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Storyboard methods

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"scanLoc"]) {
        LocationDetailViewController *destination = segue.destinationViewController;
        Location *location = sender;
        destination.title = location.name;
        destination.location = location;
    }
    else {
        ScanViewController *destination = segue.destinationViewController;
        destination = [destination initWithDelegate:self showCancel:YES OneDMode:NO];
        QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
        NSSet *readers = [[NSSet alloc ] initWithObjects:qrcodeReader,nil];
        destination.readers = readers;
        NSBundle *mainBundle = [NSBundle mainBundle];
        destination.soundToPlay =
        [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    }

}

@end
