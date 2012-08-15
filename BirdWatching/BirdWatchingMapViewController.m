//
//  BirdWatchingMapViewController.m
//  BirdWatching
//
//  Created by Abby Langner on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"
#import "BirdWatchingMapViewController.h"


@implementation BirdWatchingMapViewController

@synthesize sighting = _sighting;
@synthesize mapView;

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
    
    MKCoordinateRegion newRegion;
    newRegion.center.latitude = [self.sighting.latitude floatValue];
    newRegion.center.longitude = [self.sighting.longitude floatValue];
    newRegion.span.latitudeDelta = 0.112872;
    newRegion.span.longitudeDelta = 0.109863;
    
    [self.mapView setRegion:newRegion animated:YES];
    
    

    
}

- (void)viewDidLoad
{
    
    self.mapView.mapType = MKMapTypeStandard;
    
    [self configureView];
    
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
