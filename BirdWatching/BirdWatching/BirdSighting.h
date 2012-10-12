//
//  BirdSighting.h
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BirdSighting : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) UIImage *image;
-(id)initWithName:(NSString *)name location:(NSString *)location date:(NSDate *)date latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude image:(UIImage *)image;
- (id)proxyForJson;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
