//
//  BirdWatchingAnnotation.m
//  BirdWatching
//
//  Created by David Hopp on 8/15/12.
//
//

#import "BirdWatchingAnnotation.h"

@implementation BirdWatchingAnnotation
- (CLLocationCoordinate2D)coordinate;
{
    CLLocationCoordinate2D theCoordinate;
    theCoordinate.latitude = 37.779999;
    theCoordinate.longitude = -122.400002;
    return theCoordinate;
}

// required if you set the MKPinAnnotationView's "canShowCallout" property to YES
- (NSString *)title
{
    return @"Golden Gate Bridge";
}

// optional
- (NSString *)subtitle
{
    return @"Opened: May 27, 1937";
}

@end
