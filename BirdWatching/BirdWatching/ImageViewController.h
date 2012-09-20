//
//  ImageViewController.h
//  BirdWatching
//
//  Created by Jay Newstrom on 9/20/12.
//
//

#import <UIKit/UIKit.h>

@protocol ImageViewControllerDelegate;

@interface ImageViewController : UIViewController <UINavigationControllerDelegate>
@property (weak, nonatomic) id <ImageViewControllerDelegate> delegate;
@end

@protocol ImageViewControllerDelegate <NSObject>
- (void)imageViewControllerDelegateDidFinish:(ImageViewController *)controller image:(UIImage *)image;
@end