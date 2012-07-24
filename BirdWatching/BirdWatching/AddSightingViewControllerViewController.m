//
//  AddSightingViewControllerViewController.m
//  BirdWatching
//
//  Created by David Hopp on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddSightingViewControllerViewController.h"

@interface AddSightingViewControllerViewController ()

@end

@implementation AddSightingViewControllerViewController

@synthesize birdNameInput = _birdNameInput;
@synthesize locationInput = _locationInput;
@synthesize delegate = _delegate;
@synthesize gpsCoordsDisplay = _gpsCoordsDisplay;
@synthesize locationManager = _locationManager;

NSNumber *latitude;
NSNumber *longitude;

-(void)viewDidLoad{
    
    [[self locationManager] startUpdatingLocation];
    
    // If it's not possible to get a location, then return.
	CLLocation *location = [locationManager location];
	if (!location) {
		return;
	}
    
    // Configure the new event with information from the location.
	CLLocationCoordinate2D coordinate = [location coordinate];
    latitude = [NSNumber numberWithDouble:coordinate.latitude];
    longitude = [NSNumber numberWithDouble:coordinate.longitude];
    
    self.gpsCoordsDisplay.text = [NSString stringWithFormat:@"φ:%.4F, λ:%.4F", latitude, longitude];
}

- (void)viewDidUnload
{
    [self setBirdNameInput:nil];
    [self setLocationInput:nil];
    locationManager = nil;
    [self setGpsCoordsDisplay:nil];
    [super viewDidUnload];
    
}

- (IBAction)cancel:(id)sender {
    [[self delegate] addSightingViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {

    
    // If it's not possible to get a location, then return.
	CLLocation *location = [locationManager location];
	if (!location) {
		return;
	}

    [[self delegate] addSightingViewControllerDidFinish:self name:self.birdNameInput.text location:self.locationInput.text latitude:latitude longitude:longitude];
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




@end
