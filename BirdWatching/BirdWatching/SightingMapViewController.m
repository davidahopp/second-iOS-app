//
//  SightingMapViewController.m
//  BirdWatching
//
//  Created by David Hopp on 8/24/12.
//
//

#import "SightingMapViewController.h"

@interface SightingMapViewController ()

@end

@implementation SightingMapViewController
@synthesize delegate = _delegate;
@synthesize sighting = _sighting;
@synthesize mapView;
@synthesize sightingAnnotations;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self != nil)
    {
        NSMutableArray *myArray = [[NSMutableArray alloc] init];
        self.sightingAnnotations = myArray;
    }
    
    return self;
}

- (void)viewDidLoad
{
    self.mapView.mapType = MKMapTypeStandard;
    
    [self configureView];
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    mapView = nil;
    mapView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (IBAction)cancel:(id)sender {
    [[self delegate] sightingMapViewDidCancel:self];
}


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
    //NSLog(@"%f", [self.sighting.latitude floatValue]);
    //NSLog(@"%f", [self.sighting.longitude floatValue]);
    newRegion.center.latitude = [[[[self.sightingAnnotations objectAtIndex:0] sighting] latitude] floatValue];
    newRegion.center.longitude = [[[[self.sightingAnnotations objectAtIndex:0] sighting] longitude] floatValue];
    
    MKCoordinateSpan span;
    span.latitudeDelta = .005;
    span.longitudeDelta = .005;
    newRegion.span = span;
    
    
    [self.mapView setRegion:newRegion animated:YES];
    
    [self.mapView addAnnotations:self.sightingAnnotations];
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

- (void)addBirdSighting:(BirdSighting *)birdSighting
{
    BirdWatchingAnnotation *birdAnnotaiton = [[BirdWatchingAnnotation alloc] initWithProperties:birdSighting];
    [self.sightingAnnotations addObject:birdAnnotaiton];
}


@end
