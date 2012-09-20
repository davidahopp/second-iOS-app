//
//  ImageViewController.m
//  BirdWatching
//
//  Created by Jay Newstrom on 9/20/12.
//
//

#import "ImageViewController.h"

@interface ImageViewController () <UIImagePickerControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *birdImageView;

@end

@implementation ImageViewController 
@synthesize birdImageView = _birdImageView;
@synthesize birdSighting = _birdSighting;

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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    self.birdImageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];

    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        UIImageWriteToSavedPhotosAlbum(self.birdImageView.image, nil, nil, nil);
    
    [self.delegate imageViewControllerDelegateDidFinish:self image:self.birdImageView.image];
    
    [picker dismissModalViewControllerAnimated:YES];
    
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	if(self.birdSighting)
    {
        self.birdImageView.image = self.birdSighting.image;
        self.title = self.birdSighting.name;
    }
}

- (void)viewDidUnload
{
    [self setBirdImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
