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
#import "ImageViewController.h"
#import "Requester.h"
#import "EditSightingViewController.h"

@interface BirdWatchingDetailViewController ()
<SightingMapViewControllerDelagate, ImageViewControllerDelegate, RequesterDelegate, EditSightingViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *birdImageView;
- (void)configureView;
@end

@implementation BirdWatchingDetailViewController
@synthesize birdImageView = _birdImageView;
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
        self.birdImageView.image = theSighting.image;
        
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
    [self setBirdImageView:nil];
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
        [sightingViewController addBirdSighting:self.sighting];
    }
    else if([segue.identifier isEqualToString:@"birdImagePicker"]) {
        ImageViewController *ivc = [segue destinationViewController];
        ivc.delegate = self;
        ivc.birdSighting = self.sighting;
    }
    else if([segue.identifier isEqualToString:@"editSighting"]){
        EditSightingViewController *esvc = segue.destinationViewController;
        esvc.delegate = self;
        esvc.birdSighting = self.sighting;
    }

}
- (IBAction)sendBirdSightingToServer:(id)sender {
    Requester *requester = [[Requester alloc] initWithRestString:@"process_any.php" andDelegate:self andIdentifier:@"sendBirdSighting"];
    
    [requester performHTTPMethod:@"POST" withData:[self.sighting formatForWeb]];
    
}

- (void)identifierDidFinishDownloading:(NSString *)identifier withJSON:(NSDictionary *)json
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Posted!"
														message:@"YAY!!"
													   delegate:nil
											  cancelButtonTitle:@"Okay"
											  otherButtonTitles:nil];
    [alertView show];
    
}

- (void)sightingMapViewDidCancel:(SightingMapViewController *)controller{
    [self dismissViewControllerAnimated:YES completion: NULL];
}

- (void)imageViewControllerDelegateDidFinish:(ImageViewController *)controller image:(UIImage *)image
{
    self.birdImageView.image = image;
}

- (void)editSightingDidUpdate:(EditSightingViewController *)controller withSighting:(BirdSighting *)sighting{
    
}


@end
