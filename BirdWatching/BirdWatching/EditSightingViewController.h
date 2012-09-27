//
//  EditSightingViewController.h
//  BirdWatching
//
//  Created by Abby Langner on 9/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BirdSighting.h"

@protocol EditSightingViewControllerDelegate;


@interface EditSightingViewController : UIViewController
@property (weak, nonatomic) id <EditSightingViewControllerDelegate> delegate;
@property (strong, nonatomic) BirdSighting *birdSighting;
@end

@protocol EditSightingViewControllerDelegate <NSObject>

- (void) editSightingDidUpdate:(EditSightingViewController *)controller withSighting:(BirdSighting *)sighting;

@end