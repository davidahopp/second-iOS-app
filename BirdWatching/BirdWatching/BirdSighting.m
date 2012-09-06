//
//  BirdSighting.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"

@implementation BirdSighting
@synthesize name = _name, location = _location, date = _date, latitude = _latitude, longitude = _longitude;

-(id)initWithName:(NSString *)name location:(NSString *)location date:(NSDate *)date latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude{
    self = [super init];

    if (self) {
        _name = name;
        _location = location;
        _date = date;
        _latitude = latitude;
        _longitude = longitude;
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.latitude forKey:@"latitude"];
    [encoder encodeObject:self.longitude forKey:@"longitude"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.name = [decoder decodeObjectForKey:@"name"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.date = [decoder decodeObjectForKey:@"date"];
        self.latitude = [decoder decodeObjectForKey:@"latitude"];
        self.longitude = [decoder decodeObjectForKey:@"longitude"];
    }
    return self;
}


@end
