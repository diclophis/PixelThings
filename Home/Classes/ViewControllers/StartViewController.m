#import "StartViewController.h"

@implementation StartViewController


@synthesize introImageView;


-(id)init {
	if ((self = [super initWithNibName:@"StartViewController" bundle:[NSBundle mainBundle]])) {
		//
	}
	return self;
}


-(void)viewDidLoad {

	NSMutableArray *introImages = [NSMutableArray arrayWithCapacity:6];
	for (NSInteger i=1; i < 7; i++) {
		[introImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"ui_Intro%03d.png", i]]];
	}
	
	[introImageView setAnimationRepeatCount:1];
	[introImageView setAnimationDuration:ANIMATION_DURATION];
	[introImageView setAnimationImages:introImages];
	[introImageView startAnimating];
	[self performSelector:@selector(didClickClose:) withObject:self afterDelay:6.1f];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] removeFromSuperview];
}


-(IBAction)didClickClose:(id)sender {
	[self viewWillDisappear:NO];
}


@end
