//
//  ImageViewController.h
//  BirdWatching
//
//  Created by Jay Newstrom on 9/20/12.
//
//

#import <UIKit/UIKit.h>
#import "BirdSighting.h"

@protocol ImageViewControllerDelegate;

@interface ImageViewController : UIViewController <UINavigationControllerDelegate>
@property (weak, nonatomic) id <ImageViewControllerDelegate> delegate;
@property (nonatomic, strong) BirdSighting *birdSighting;
@end

@protocol ImageViewControllerDelegate <NSObject>
- (void)imageViewControllerDelegateDidFinish:(ImageViewController *)controller image:(UIImage *)image;
@end