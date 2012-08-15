//
//  BirdWatchingAnnotation.h
//  BirdWatching
//
//  Created by David Hopp on 8/15/12.
//
//

#import <MapKit/MapKit.h>
#import "BirdSighting.h"

@interface BirdWatchingAnnotation : NSObject <MKAnnotation>
{
    
}

@property (nonatomic, strong) BirdSighting *sighting;

- (id) initWithProperties: (BirdSighting *)sighting;

@end
