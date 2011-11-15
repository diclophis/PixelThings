// GPL

#import "MenuViewController.h"


@implementation MenuViewController


@synthesize expanded;
@synthesize moving;
@synthesize selectedAction;


-(void)viewDidLoad {
	[super viewDidLoad];
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];
	[self setMoving:NO];
	[self setExpanded:NO];
}


-(void)dealloc {
	[selectedAction release];
	[super dealloc];
}


-(void)disable {
	for (id subview in [[self view] subviews]) {
		[subview setUserInteractionEnabled:NO];
	}
}


-(void)enable {
	for (id subview in [[self view] subviews]) {
		[subview setUserInteractionEnabled:YES];
	}
}


-(void)toggle {
	if (moving) {
		return;
	}

	[self disable];
	if (expanded) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[[self view] setFrame:CGRectOffset([[self view] frame], 0.0f, [[self view] frame].size.height - 40.0f)];
		[self setExpanded:NO];
		[self setMoving:YES];
		[UIView setAnimationDidStopSelector:@selector(firstStage:finished:context:)];
		[UIView commitAnimations];
	} else {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[[self view] setFrame:CGRectOffset([[self view] frame], 0.0f, -(([[self view] frame].size.height - 40.0f) + 5))];
		[self setExpanded:YES];
		[self setMoving:YES];
		[UIView setAnimationDidStopSelector:@selector(firstStage:finished:context:)];
		[UIView commitAnimations];
	}
}


-(void)viewWillDisappear:(BOOL)animated {
	[self disable];
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 80.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[self setExpanded:YES];
	[[self view] setFrame:CGRectMake(0.0f, 240.0f, 480.0f, 80.0f)];
}


-(void)viewDidAppear:(BOOL)animated {
	[self enable];
}


-(void)firstStage:(NSString *)animationID finished:(BOOL)finished context:(void *)contex {
	if (expanded) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[[self view] setFrame:CGRectOffset([[self view] frame], 0.0f, 5.0f)];
		[self setExpanded:YES];
		[UIView setAnimationDidStopSelector:@selector(secondStage:finished:context:)];
		[UIView commitAnimations];
	} else {
		[self setMoving:NO];
		[self enable];
	}
}


-(void)secondStage:(NSString *)animationID finished:(BOOL)finished context:(void *)contex {
	[self setMoving:NO];
	[self enable];
}



@end
