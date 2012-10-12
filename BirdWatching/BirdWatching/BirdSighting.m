//
//  BirdSighting.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"

@implementation BirdSighting
@synthesize name = _name, location = _location, date = _date, latitude = _latitude, longitude = _longitude, image = _image;

#define KEY_NAME @"name"
#define KEY_LOCATION @"location"
#define KEY_LATITUDE @"latitude"
#define KEY_LONGITUDE @"longitude"
#define KEY_DATE @"sightingDate"
#define KEY_IMAGE @"image"

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        _name = [dictionary objectForKey:KEY_NAME];
        _location = [dictionary objectForKey:KEY_LOCATION];
        _date = [dictionary objectForKey:KEY_DATE];
        _latitude = [dictionary objectForKey:KEY_LATITUDE];
        _longitude = [dictionary objectForKey:KEY_LONGITUDE];
        _image = [dictionary objectForKey:KEY_IMAGE];
        return self;
    }
    
    return nil;
}

-(id)initWithName:(NSString *)name location:(NSString *)location date:(NSDate *)date latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude image:(UIImage *)image{
    self = [super init];

    if (self) {
        _name = name;
        _location = location;
        _date = date;
        _latitude = latitude;
        _longitude = longitude;
        _image = image;
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:KEY_NAME];
    [encoder encodeObject:self.location forKey:KEY_LOCATION];
    [encoder encodeObject:self.date forKey:KEY_DATE];
    [encoder encodeObject:self.latitude forKey:KEY_LATITUDE];
    [encoder encodeObject:self.longitude forKey:KEY_LONGITUDE];
    [encoder encodeObject:self.image forKey:KEY_IMAGE];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:KEY_NAME];
        self.location = [decoder decodeObjectForKey:KEY_LOCATION];
        self.date = [decoder decodeObjectForKey:KEY_DATE];
        self.latitude = [decoder decodeObjectForKey:KEY_LATITUDE];
        self.longitude = [decoder decodeObjectForKey:KEY_LONGITUDE];
        self.image = [decoder decodeObjectForKey:KEY_IMAGE];
    }
    return self;
}

- (id)proxyForJson
{
    NSDictionary *birdSightingDictionary = [NSDictionary dictionaryWithObjectsAndKeys:self.name, KEY_NAME, self.location, KEY_LOCATION, self.latitude, KEY_LATITUDE, self.longitude, KEY_LONGITUDE, nil];
    
    return [NSDictionary dictionaryWithObject:birdSightingDictionary forKey:@"bird_sighting"];
}


@end
