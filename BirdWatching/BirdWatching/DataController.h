//
//  DataController.h
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Requester.h"

@protocol DataControllerDelegate
- (void)reloadData;
@end

@class BirdSighting;

@interface DataController : NSObject <RequesterDelegate>
@property (nonatomic, copy) NSMutableArray *masterBirdSightingList;
@property (nonatomic, weak) id <DataControllerDelegate, NSObject> delegate;

- (NSUInteger)countOfList;
- (BirdSighting *)objectInListAtIndex:(NSUInteger)theIndex;
- (void)addBirdSightingWithName:(NSString *)inputBirdName location:(NSString *)inputLocation latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude image:(UIImage *)image;
- (void)removeObjectAtIndex:(int)index;
- (void)initializeDataList;

@end
