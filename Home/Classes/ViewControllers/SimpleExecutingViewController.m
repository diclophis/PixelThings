// GPL

#import "SimpleExecutingViewController.h"


@implementation SimpleExecutingViewController


@synthesize activityView;
@synthesize progressView;
@synthesize progress;


-(id)init {
	if ((self = [super init])) {
		UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		[self setView:theView];
		[theView release];
		
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		
		
		UIProgressView *theProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
		[self setProgressView:theProgressView];
		[theProgressView release];
		
		[[self activityView] setHidden:YES];
		[[self activityView] setCenter:[[self view] center]];
		[[self activityView] startAnimating];
		
		[[self progressView] setHidden:YES];
		[[self progressView] setCenter:[[self view] center]];
		
		[[self view] setBackgroundColor:[UIColor grayColor]];
		[[self view] setAlpha:0.5f];
		[[self view] addSubview:activityView];
		[[self view] addSubview:progressView];

	}
	return self;
}


-(void)updateProgress:(NSNumber *)theProgress {
	[self setProgress:theProgress];
	 if ([progress floatValue] > 0.0f) {
		 [[self activityView] setHidden:YES];
		 [[self progressView] setHidden:NO];
		 [[self progressView] setProgress:[[self progress] floatValue]];
	 } else {
		 [[self activityView] setHidden:NO];
		 [[self progressView] setHidden:YES];
	 }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)dealloc {
	[activityView release];
	[progressView release];
	[progress release];
  [super dealloc];
}


@end
