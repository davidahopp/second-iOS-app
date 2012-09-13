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

    [self.mapView addAnnotations:self.sightingAnnotations];
    
    [self zoomToFitMapAnnotations:self.mapView];

}

- (void)zoomToFitMapAnnotations:(MKMapView *)mapView {
    if ([mapView.annotations count] == 0) return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(id<MKAnnotation> annotation in mapView.annotations) {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1;
    if(region.span.latitudeDelta < .005){
        region.span.latitudeDelta = .005;
    }
    
    // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1;
    if(region.span.longitudeDelta < .005){
        region.span.longitudeDelta = .005;
    }
    
    region = [mapView regionThatFits:region];
    [mapView setRegion:region animated:YES];
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
