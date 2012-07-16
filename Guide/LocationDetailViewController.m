//
//  LocationDetailViewController.m
//  Guide
//
//  Created by Scott Andrus on 6/13/12.
//  Copyright (c) 2012 Vanderbilt University. All rights reserved.
//

#import "LocationDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Sizer.h"
#import "NavBarManager.h"

@interface LocationDetailViewController ()

@end

@implementation LocationDetailViewController
@synthesize descriptionLabel;
@synthesize checkInButton;
@synthesize mapButton;
@synthesize videoButton;
@synthesize audioButton;
@synthesize nameLabel;
@synthesize coverImageView;
@synthesize universityLabel;

@synthesize location = _location;

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
    
    // Round corners of description label (QuartzCore)
    self.descriptionLabel.layer.cornerRadius = 11;
    self.descriptionLabel.clipsToBounds = YES;
    self.descriptionLabel.layer.borderColor = [[UIColor grayColor] CGColor];
    //self.descriptionLabel.layer.opacity = .5;
    self.descriptionLabel.layer.borderWidth = .5;
    
    // Format photo imageview
    self.coverImageView.clipsToBounds = YES;
    self.coverImageView.layer.borderColor = [[UIColor blackColor] CGColor];
    self.coverImageView.layer.borderWidth = .5;
    
    
    // Set text
    self.nameLabel.text = self.location.name;
    self.descriptionLabel.text = self.location.placeDescription;
    
    // Size textView
    self.descriptionLabel.frame = [Sizer sizeTextView:self.descriptionLabel];
    
    // Download photo
    [self downloadPhoto];
}

- (void)viewWillAppear:(BOOL)animated {
    UINavigationBar *navBar = self.navigationController.navigationBar;
    navBar = [NavBarManager removeLogoFromNavBar:navBar];
}

- (void)downloadPhoto {
    // Download photo
    if (![self.location.name isEqualToString:@"Featheringill Hall"]) {
        UIActivityIndicatorView *loading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [loading startAnimating];
        UIBarButtonItem * temp = self.navigationItem.rightBarButtonItem;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:loading];
        
        dispatch_queue_t downloadQueue = dispatch_queue_create("flickr donwloader", NULL);
        dispatch_async(downloadQueue, ^{
            
            NSData *imgUrl = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.location.imagePath]];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.coverImageView setImage:[UIImage imageWithData:imgUrl]];
                [loading stopAnimating];
                self.navigationItem.rightBarButtonItem = temp;
            });
        });
        dispatch_release(downloadQueue);
    }
    else {
        [self.coverImageView setImage:[UIImage imageNamed:@"Featheringill.jpeg"]];
    }
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

- (void)viewDidUnload {
    [self setDescriptionLabel:nil];
    [self setCheckInButton:nil];
    [self setMapButton:nil];
    [self setVideoButton:nil];
    [self setAudioButton:nil];
    [self setCoverImageView:nil];
    [self setNameLabel:nil];
    [self setUniversityLabel:nil];
    [super viewDidUnload];
}
@end
