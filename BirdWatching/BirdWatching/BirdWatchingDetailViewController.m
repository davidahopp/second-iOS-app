//
//  BirdWatchingDetailViewController.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"
#import "BirdWatchingDetailViewController.h"
#import "SightingMapViewController.h"

@interface BirdWatchingDetailViewController ()
<SightingMapViewControllerDelagate>
- (void)configureView;
@end

@implementation BirdWatchingDetailViewController
@synthesize gpsCoordsLabel = _gpsCoordsLabel;

@synthesize sighting = _sighting, birdNameLabel = _birdNameLabel, locationLabel = _locationLabel, dateLabel = _dateLabel;

#pragma mark - Managing the detail item

- (void)setSighting:(BirdSighting *) newSighting
{
    if (_sighting != newSighting) {
        _sighting = newSighting;
        // Update the view.
        [self configureView];
    }
    
}

- (void)configureView
{
    // Update the user interface for the detail item.
    BirdSighting *theSighting = self.sighting;
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    if (theSighting) {
        self.gpsCoordsLabel.text = [NSString stringWithFormat:@"lat:%.4f, long:%.4f", [theSighting.latitude floatValue], [theSighting.longitude floatValue]];
        self.birdNameLabel.text = theSighting.name;
        self.locationLabel.text = theSighting.location;
        self.dateLabel.text = [formatter stringFromDate:(NSDate
                                                         *)theSighting.date];
        
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    self.sighting = nil;
    [self setGpsCoordsLabel:nil];
    [super viewDidUnload];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowBirdSightingMap"]) {
        SightingMapViewController *sightingViewController = (SightingMapViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        sightingViewController.delegate = self;
        sightingViewController.sighting = [self sighting];

    }

}

- (void)sightingMapViewDidCancel:(SightingMapViewController *)controller{
    [self dismissViewControllerAnimated:YES completion: NULL];
}


@end
