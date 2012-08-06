//
//  DataController.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"
#import "BirdSighting.h"

@interface DataController ()
    - (void)initializeDefaultDataList;
@end

@implementation DataController

@synthesize masterBirdSightingList = _masterBirdSightingList;

- (id)init {
    if (self = [super init]) {
        [self initializeDefaultDataList];
        return self;
    }
    return nil;
}

- (void)initializeDefaultDataList {
    NSMutableArray *sightingList = [[NSMutableArray alloc] init];
    self.masterBirdSightingList = sightingList;
    [self addBirdSightingWithName:@"Pigeon" location:@"Everywhere" latitude:[NSNumber numberWithDouble:37.78] longitude:[NSNumber numberWithDouble:-122.40]];
}


- (void)setMasterBirdSightingList:(NSMutableArray *)newList {
    if (_masterBirdSightingList != newList) {
        _masterBirdSightingList = [newList mutableCopy];
    }
}

- (NSUInteger)countOfList {
   return [self.masterBirdSightingList count]; 
}

- (BirdSighting *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterBirdSightingList objectAtIndex:theIndex];
}

- (void)addBirdSightingWithName:(NSString *)inputBirdName
location:(NSString *)inputLocation latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude {
    BirdSighting *sighting;

    NSDate *today = [NSDate date];
    sighting = [[BirdSighting alloc] initWithName:inputBirdName
                                         location:inputLocation date:today latitude:latitude longitude:longitude];
    [self.masterBirdSightingList addObject:sighting];
}

@end
