//
//  AddSightingViewControllerViewController.h
//  BirdWatching
//
//  Created by David Hopp on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import <UIKit/UIKit.h>

@protocol AddSightingViewControllerDelegate;

@interface AddSightingViewControllerViewController : UITableViewController <UITextFieldDelegate,CLLocationManagerDelegate>{
    
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UILabel *gpsCoordsDisplay;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UITextField *birdNameInput;
@property (weak, nonatomic) IBOutlet UITextField *locationInput;
@property (weak, nonatomic) id <AddSightingViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end

@protocol AddSightingViewControllerDelegate <NSObject>
- (void)addSightingViewControllerDidCancel:(AddSightingViewControllerViewController *)controller;
- (void)addSightingViewControllerDidFinish:(AddSightingViewControllerViewController *)controller name:(NSString *)name location:(NSString *)location latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude image:(UIImage *)image;
@end