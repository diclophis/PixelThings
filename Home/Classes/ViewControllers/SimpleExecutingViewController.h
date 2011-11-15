// GPL

#import <UIKit/UIKit.h>


@interface SimpleExecutingViewController : UIViewController {
	UIProgressView *progressView;
	UIActivityIndicatorView *activityView;
	NSNumber *progress;
}


@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIProgressView *progressView;
@property (retain) NSNumber *progress;


-(void)updateProgress:(NSNumber *)theProgress;


@end
