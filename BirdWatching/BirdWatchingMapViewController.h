//
//  BirdWatchingMapViewController.h
//  BirdWatching
//
//  Created by Abby Langner on 8/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class BirdSighting;

IBOutlet MKMapView *mapView;

@interface BirdWatchingMapViewController : UIViewController <MKMapViewDelegate>{
    MKMapView *mapView;
}

@property (strong, nonatomic) BirdSighting *sighting;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end
