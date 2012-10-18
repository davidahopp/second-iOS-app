//
//  BirdWatchingMasterViewController.m
//  BirdWatching
//
//  Created by David Hopp on 6/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BirdSighting.h"

#import "DataController.h"

#import "BirdWatchingMasterViewController.h"

#import "BirdWatchingDetailViewController.h"

#import "AddSightingViewControllerViewController.h"
#import "SightingMapViewController.h"


@interface BirdWatchingMasterViewController ()
<AddSightingViewControllerDelegate, SightingMapViewControllerDelagate, DataControllerDelegate>
@end

/*
@interface BirdWatchingMasterViewController () {
    NSMutableArray *_objects;
}
@end
*/

@implementation BirdWatchingMasterViewController

@synthesize dataController = _dataController;


- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    */
    
    self.dataController = [[DataController alloc] init];
    self.dataController.delegate = self;
    [self.dataController initializeDataList];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)addSightingViewControllerDidCancel:(AddSightingViewControllerViewController *)controller {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)addSightingViewControllerDidFinish:(AddSightingViewControllerViewController *)controller name:(NSString *)name location:(NSString *)location latitude:(NSNumber *)latitude longitude:(NSNumber *)longitude image:(UIImage *)image {
    
    if ([name length] || [location length]) {
        [self.dataController addBirdSightingWithName:name location:location latitude:latitude longitude:longitude image:image];
        [[self tableView] reloadData];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"BirdSightingCell";
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    BirdSighting *sightingAtIndex = [self.dataController
                                     objectInListAtIndex:indexPath.row];
    [[cell textLabel] setText:sightingAtIndex.name];
    [[cell detailTextLabel] setText:[formatter stringFromDate:(NSDate *)sightingAtIndex.date]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //delete local
        [self.dataController removeObjectAtIndex:indexPath.row];
        //show delete local
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowSightingDetails"]) {
        BirdWatchingDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.sighting = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    } else if ([[segue identifier] isEqualToString:@"ShowAddSightingView"]) {
        AddSightingViewControllerViewController *addController = (AddSightingViewControllerViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        addController.delegate = self;
    } else if ([[segue identifier] isEqualToString:@"ShowAllBirdSightingsMap"]) {
        SightingMapViewController *sightingViewController = (SightingMapViewController *)[[[segue destinationViewController] viewControllers] objectAtIndex:0];
        
        sightingViewController.delegate = self;
        
        NSMutableArray *birdSightings = [self.dataController masterBirdSightingList];
        
        for (int i = 0; i < [birdSightings count]; i++) {
            [sightingViewController addBirdSighting:[birdSightings objectAtIndex:i]];
        }
    }
    
    
    
}

- (void)sightingMapViewDidCancel:(SightingMapViewController *)controller{
    [self dismissViewControllerAnimated:YES completion: NULL];
}

- (void)reloadData
{
    [self.tableView reloadData];
}


@end
