//
//  BirdWatchingMapViewController.m
//  BirdWatching
//
//  Created by Abby Langner on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"
#import "BirdWatchingMapViewController.h"

@interface BirdWatchingMapViewController ()
-(void)configureView;
@end

@implementation BirdWatchingMapViewController

@synthesize sighting = _sighting;
@synthesize mapView = _mapView;

- (void)setSighting:(BirdSighting *) newSighting
{
    if (_sighting != newSighting) {
        _sighting = newSighting;
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    NSLog(@"%f", [self.sighting.latitude floatValue]);
    NSLog(@"%f", [self.sighting.longitude floatValue]);
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = [self.sighting.latitude floatValue];
    location.longitude = [self.sighting.longitude floatValue];
    region.span = span;
    region.center = location;
    
    [self.mapView setRegion:region animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    [self.mapView setMapType:MKMapTypeHybrid];
    
    [self.mapView setDelegate:self];
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
