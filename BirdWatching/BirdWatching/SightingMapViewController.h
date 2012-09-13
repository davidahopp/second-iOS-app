//
//  SightingMapViewController.h
//  BirdWatching
//
//  Created by David Hopp on 8/24/12.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BirdWatchingAnnotation.h"

@class BirdSighting;

@protocol SightingMapViewControllerDelagate;

@interface SightingMapViewController : UIViewController <MKMapViewDelegate>
{

    MKMapView *mapView;
    NSMutableArray *sightingAnnotations;
}

    @property (weak, nonatomic) id <SightingMapViewControllerDelagate>delegate;
    @property (strong, nonatomic) BirdSighting *sighting;
    @property (nonatomic, retain) IBOutlet MKMapView *mapView;
    @property(nonatomic,retain) NSMutableArray *sightingAnnotations;


    - (IBAction)cancel:(id)sender;
- (void)addBirdSighting:(BirdSighting *)birdSighting;
@end

@protocol SightingMapViewControllerDelagate <NSObject>

- (void) sightingMapViewDidCancel:(SightingMapViewController *)controller;

@end