//
//  AddSightingViewControllerViewController.m
//  BirdWatching
//
//  Created by David Hopp on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddSightingViewControllerViewController.h"
#import "ImageViewController.h"

@interface AddSightingViewControllerViewController () <ImageViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *birdSightingView;

@end

@implementation AddSightingViewControllerViewController
@synthesize birdSightingView = _birdSightingView;

@synthesize birdNameInput = _birdNameInput;
@synthesize locationInput = _locationInput;
@synthesize delegate = _delegate;
@synthesize gpsCoordsDisplay = _gpsCoordsDisplay;
@synthesize locationManager = _locationManager;

NSNumber *latitude;
NSNumber *longitude;

-(void)viewDidLoad{
    
    [[self locationManager] startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [self.locationManager stopUpdatingLocation];
    NSLog(@"%@", newLocation);
    
    // Configure the new event with information from the location.
	CLLocationCoordinate2D coordinate = [newLocation coordinate];
    latitude = [NSNumber numberWithDouble:coordinate.latitude];
    longitude = [NSNumber numberWithDouble:coordinate.longitude];
    
    self.gpsCoordsDisplay.text = [NSString stringWithFormat:@"lat:%.4f, long:%.4f", [latitude floatValue], [longitude floatValue]];
}

- (void)viewDidUnload
{
    [self setBirdNameInput:nil];
    [self setLocationInput:nil];
    locationManager = nil;
    [self setGpsCoordsDisplay:nil];
    [self setBirdSightingView:nil];
    [super viewDidUnload];
    
}

- (IBAction)cancel:(id)sender {
    [[self delegate] addSightingViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [[self delegate] addSightingViewControllerDidFinish:self name:self.birdNameInput.text location:self.locationInput.text latitude:latitude longitude:longitude image:self.birdSightingView.image];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.birdNameInput) || (textField == self.locationInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[locationManager setDelegate:self];
	
	return locationManager;
}

- (void)imageViewControllerDelegateDidFinish:(ImageViewController *)controller image:(UIImage *)image
{
    self.birdSightingView.image = image;
}



@end
