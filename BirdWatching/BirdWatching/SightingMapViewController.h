//
//  SightingMapViewController.h
//  BirdWatching
//
//  Created by David Hopp on 8/24/12.
//
//

#import <UIKit/UIKit.h>

@protocol SightingMapViewControllerDelagate;

@interface SightingMapViewController : UIViewController

@property (weak, nonatomic) id <SightingMapViewControllerDelagate>delegate;

- (IBAction)cancel:(id)sender;

@end

@protocol SightingMapViewControllerDelagate <NSObject>

- (void) sightingMapViewDidCancel:(SightingMapViewController *)controller;

@end