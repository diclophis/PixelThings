// GPL


#import <CoreGraphics/CoreGraphics.h>
#import "TickerViewController.h"


#define REPORTWIDTH 480.0f


@implementation TickerViewController


@synthesize selectedAction;
@synthesize reports;
@synthesize messages;


-(id)init {
	if ((self = [super init])) {
		UIView *theView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 30.0f)];
		[self setView:theView];
		[theView release];
		[self setReports:[NSMutableArray arrayWithCapacity:0]];
		for (NSInteger i = 0; i<(480.0f / REPORTWIDTH) + 1; i++) {
			//Report *theReport = [[Report alloc] init];
			//[theReport setFrame:CGRectMake((REPORTWIDTH * i) - REPORTWIDTH, 0, REPORTWIDTH, 30.0f)];
			//[reports addObject:theReport];
			//[[self view] addSubview:theReport];
			//[theReport release];
		}
		[self setMessages:[NSMutableArray arrayWithCapacity:0]];
		
		[[self view] setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.75f]];
		
		UIButton *theBackButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		[theBackButton addTarget:self action:@selector(didClickInfo:) forControlEvents:UIControlEventTouchUpInside];
		[theBackButton setFrame:CGRectMake(450.0f, 0.0f, 30.0f, 30.0f)];
		[[self view] addSubview:theBackButton];
	}
	return self;
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(-480.0f, 0.0f, 480.0f, 40.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
}


-(void)scrollStopped:(NSString *)animationID finished:(BOOL)finished context:(void *)contex {
	/*
	for (id report in reports) {
		if (report.center.x <= - (REPORTWIDTH / 2.0f)) {
			report.center = CGPointMake(480.0f + (REPORTWIDTH / 2.0f), report.center.y);
			if ([messages count]) {
				[report updateBody:[messages objectAtIndex:0]];
				[messages removeObjectAtIndex:0];
			} else {
				[report updateBody:@""];
			}
		}
	}
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(scrollStopped:finished:context:)];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	for (Report *report in reports) {
		report.center = CGPointMake(report.center.x - REPORTWIDTH, report.center.y);
	}
	[UIView commitAnimations];
  */
}


-(void)didClickInfo:(id)sender {
	[self setSelectedAction:@"Info"];
}


-(void)enqueueMessage:(NSString *)theMessage withType:(NSString *)theType {
	[messages addObject:theMessage];
}


- (void)dealloc {
	[reports release];
	[selectedAction release];
	[messages release];
  [super dealloc];
}


@end

