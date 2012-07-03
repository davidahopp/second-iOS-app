//
//  AddSightingViewControllerViewController.m
//  BirdWatching
//
//  Created by David Hopp on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddSightingViewControllerViewController.h"

@interface AddSightingViewControllerViewController ()

@end

@implementation AddSightingViewControllerViewController
@synthesize birdNameInput = _birdNameInput;
@synthesize locationInput = _locationInput;
@synthesize delegate = _delegate;

- (void)viewDidUnload
{
    [self setBirdNameInput:nil];
    [self setLocationInput:nil];
    [super viewDidUnload];
    
}

- (IBAction)cancel:(id)sender {
    [[self delegate] addSightingViewControllerDidCancel:self];
}

- (IBAction)done:(id)sender {
    [[self delegate] addSightingViewControllerDidFinish:self name:self.birdNameInput.text location:self.locationInput.text];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ((textField == self.birdNameInput) || (textField == self.locationInput)) {
        [textField resignFirstResponder];
    }
    return YES;
}




@end
