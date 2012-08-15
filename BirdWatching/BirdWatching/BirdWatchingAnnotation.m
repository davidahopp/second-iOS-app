//
//  BirdWatchingAnnotation.m
//  BirdWatching
//
//  Created by David Hopp on 8/15/12.
//
//

#import "BirdWatchingAnnotation.h"


@implementation BirdWatchingAnnotation

@synthesize sighting = _sighting;

- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = [_sighting.latitude floatValue];
    theCoordinate.longitude = [_sighting.longitude floatValue];
    return theCoordinate;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return _sighting.name;
}

// optional
- (NSString *)subtitle
{
    return _sighting.location;
}

- (id) initWithProperties: (BirdSighting *)sighting
{
    self = [super init];
        
    if (self) {
        _sighting = sighting;
        return self;
    }
    return nil;
    
}

@end
