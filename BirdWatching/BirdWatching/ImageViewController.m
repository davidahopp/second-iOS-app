//
//  ImageViewController.m
//  BirdWatching
//
//  Created by Jay Newstrom on 9/20/12.
//
//

#import "ImageViewController.h"

@interface ImageViewController () <UIImagePickerControllerDelegate>

@end

@implementation ImageViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)loadExistingImageButtonClicked:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    //imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, (NSString *) kUTTypeMovie, nil];
    
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];
}

- (IBAction)loadCameraButtonClicked:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.delegate = self;
    
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    //imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, (NSString *) kUTTypeMovie, nil];
    
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
