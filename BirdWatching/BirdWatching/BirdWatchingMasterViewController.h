//
//  BirdWatchingMasterViewController.h
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BirdSightingDataController;

@interface BirdWatchingMasterViewController : UITableViewController
    @property (strong, nonatomic) DataController *dataController;
@end
