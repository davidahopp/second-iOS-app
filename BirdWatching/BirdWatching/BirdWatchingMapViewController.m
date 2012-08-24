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
@synthesize sightingAnnotations;
@synthesize delegate = _delegate;

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

    MKCoordinateRegion newRegion;
    newRegion.center.latitude = [self.sighting.latitude floatValue];
    newRegion.center.longitude = [self.sighting.longitude floatValue];

    
    [self.mapView setRegion:newRegion animated:YES];
    
    [self.mapView addAnnotations:self.sightingAnnotations];
}

- (void)viewDidLoad
{
    NSMutableArray *myArray = [[NSMutableArray alloc] init];
	self.sightingAnnotations = myArray;
    
    BirdWatchingAnnotation *annotation = [[BirdWatchingAnnotation alloc] initWithProperties:self.sighting];

    [self.sightingAnnotations addObject:annotation];
    
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

- (MKAnnotationView *) mapView:(MKMapView *)thisMapView viewForAnnotation:(BirdWatchingAnnotation *)annotation
{
	
	//the annotation view objects act like cells in a tableview.  When off screen,
	//they are added to a queue waiting to be reused.  This code mirrors that for
	//getting a table cell.  First check if the queue has available annotation views
	//of the right type, identified by the identifier string.  If nil is returned,
	//then allocate a new annotation view.
	
	static NSString *birdWatchingIdentifier = @"BirdWathcingAnnotationViewIdentifier";
    
    //the result of the call is being cast (MKPinAnnotationView *) to the correct
    //view class or else the compiler complains
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[thisMapView dequeueReusableAnnotationViewWithIdentifier:birdWatchingIdentifier];
    
	if(annotationView == nil)
	{
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:birdWatchingIdentifier];
	}

    annotationView.pinColor = MKPinAnnotationColorGreen;
    
    //pin drops when it first appears
    annotationView.animatesDrop=TRUE;
    
    //tapping the pin produces a gray box which shows title and subtitle
    annotationView.canShowCallout = YES;
    
    return annotationView;
}

- (IBAction)cancel:(id)sender {
  [[self delegate] birdWatchingMapViewControllerDidCancel:self];  
}
@end
