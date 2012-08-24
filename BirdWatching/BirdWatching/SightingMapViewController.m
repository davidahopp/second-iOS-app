//
//  SightingMapViewController.m
//  BirdWatching
//
//  Created by David Hopp on 8/24/12.
//
//

#import "SightingMapViewController.h"

@interface SightingMapViewController ()

@end

@implementation SightingMapViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
}


- (IBAction)cancel:(id)sender {
    NSLog(@"here");
    [[self delegate] sightingMapViewDidCancel:self];
}
@end
