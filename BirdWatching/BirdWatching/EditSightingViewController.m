//
//  EditSightingViewController.m
//  BirdWatching
//
//  Created by Abby Langner on 9/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditSightingViewController.h"

@interface EditSightingViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *latituteTextField;
@property (weak, nonatomic) IBOutlet UITextField *longitudeTextField;

@end

@implementation EditSightingViewController
@synthesize nameTextField;
@synthesize locationTextField;
@synthesize dateTextField;
@synthesize latituteTextField;
@synthesize longitudeTextField;
@synthesize birdSighting;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setNameTextField:nil];
    [self setLocationTextField:nil];
    [self setDateTextField:nil];
    [self setLatituteTextField:nil];
    [self setLongitudeTextField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)save:(id)sender {
}
- (IBAction)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
