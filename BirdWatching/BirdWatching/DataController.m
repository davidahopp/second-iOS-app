//
//  DataController.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataController.h"
#import "BirdSighting.h"

#define BIRD_ARRAY_TAG @"birdArray"

@interface DataController ()
- (void)initializeDataList;
- (void)syncronizeData;
@end

@implementation DataController

@synthesize masterBirdSightingList = _masterBirdSightingList;

- (id)init {
    if (self = [super init]) {
        [self initializeDataList];
        return self;
    }
    return nil;
}

- (void)initializeDataList {
    //NSMutableArray *sightingList = [[NSMutableArray alloc] init];
    //self.masterBirdSightingList = sightingList;

    NSData *myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey: [NSString stringWithFormat:BIRD_ARRAY_TAG]];
    NSArray *decodedArray = [NSKeyedUnarchiver unarchiveObjectWithData: myDecodedObject];
    self.masterBirdSightingList = [decodedArray mutableCopy];
    if (self.masterBirdSightingList == nil)
    {
        self.masterBirdSightingList = [[NSMutableArray alloc] init];
    }
    //[self addBirdSightingWithName:@"Pigeon" location:@"Everywhere" latitude:[NSNumber numberWithDouble:37.78] longitude:[NSNumber numberWithDouble:-122.40 image:nil]];
    //[self addBirdSightingWithName:@"Pigeon1" location:@"Everywhere" latitude:[NSNumber numberWithDouble:36.78] longitude:[NSNumber numberWithDouble:-122.40 image:nil]];
    //[self addBirdSightingWithName:@"Pigeon2" location:@"Everywhere" latitude:[NSNumber numberWithDouble:37.78] longitude:[NSNumber numberWithDouble:-120.40 image:nil]];
    //[self addBirdSightingWithName:@"Pigeon3" location:@"Everywhere" latitude:[NSNumber numberWithDouble:37.78] longitude:[NSNumber numberWithDouble:-123.40 image:nil]];
}


- (void)setMasterBirdSightingList:(NSMutableArray *)newList {
    if (_masterBirdSightingList != newList) {
        _masterBirdSightingList = [newList mutableCopy];
    }
}

- (void)removeObjectAtIndex:(int)index
{
    [self.masterBirdSightingList removeObjectAtIndex:index];
    [self syncronizeData];
}

- (NSUInteger)countOfList {
   return [self.masterBirdSightingList count]; 
}

- (BirdSighting *)objectInListAtIndex:(NSUInteger)theIndex {
    return [self.masterBirdSightingList objectAtIndex:theIndex];
}

- (void)addBirdSightingWithName:(NSString *)inputBirdName
                       location:(NSString *)inputLocation
                       latitude:(NSNumber *)latitude
longitude:(NSNumber *)longitude image:(UIImage *) image{
    
    BirdSighting *sighting;

    NSDate *today = [NSDate date];
    sighting = [[BirdSighting alloc] initWithName:inputBirdName location:inputLocation date:today latitude:latitude longitude:longitude image:image];
    [self.masterBirdSightingList addObject:sighting];
    
    [self syncronizeData];
}

- (void)syncronizeData
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:self.masterBirdSightingList];
    [defaults setObject:myEncodedObject forKey:BIRD_ARRAY_TAG];
    
    [defaults synchronize];
}

@end
