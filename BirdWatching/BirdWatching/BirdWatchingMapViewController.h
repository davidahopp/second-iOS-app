//
//  BirdWatchingMapViewController.h
//  BirdWatching
//
//  Created by Abby Langner on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BirdWatchingAnnotation.h"

@class BirdSighting;

@protocol BirdWatchingMapViewControllerDelegate;

@interface BirdWatchingMapViewController : UIViewController <MKMapViewDelegate>
{
    MKMapView *mapView;
    NSMutableArray *sightingAnnotations;
}

@property (strong, nonatomic) BirdSighting *sighting;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic,retain) NSMutableArray *sightingAnnotations;
@property (weak, nonatomic) id <BirdWatchingMapViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;

@end

@protocol BirdWatchingMapViewControllerDelegate <NSObject>

- (void) birdWatchingMapViewControllerDidCancel:(BirdWatchingMapViewController *)controller;

@end
