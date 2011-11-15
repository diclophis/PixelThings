// GPL

#import "StatusBubble.h"
#import "AnimationSystem.h"
#import "Item.h"

@implementation StatusBubble

@synthesize bubble;
@synthesize text;
@synthesize clickableView;


-(StatusBubble *)initWithOrigin:(CGPoint)theOrigin andTarget:(id)theTarget andClickAction:(SEL)theClickAction {
	Item *imageview;
	imageview = [[[Item alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0, 75.0)] autorelease];
	[imageview setItemId:1 andFilename:@"bubble" andVariations:1 andFrames:1 andConstrained:NO andCurrentVariation:0];
	
	CGSize size = [imageview frame].size;
	[imageview setFrame:CGRectMake(0, 0, size.width, size.height)];
	[self setBubble:imageview];
	UILabel *textView = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, size.width - 20, size.height - 50)];
	[textView setBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0]];
	[textView setMinimumFontSize:10.0f];
	[textView setAdjustsFontSizeToFitWidth:YES];
	[textView setNumberOfLines:0];
	
	[textView setBackgroundColor:[UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0]];
	[textView setFont:[UIFont systemFontOfSize:11.0]];
	[textView setTextAlignment:UITextAlignmentCenter];
	[imageview addSubview:textView];
	[textView setText:nil];
	[self setText:textView];
	 
	if ((self = [super initWithFrame:CGRectMake(theOrigin.x - size.width, theOrigin.y - size.height, size.width, size.height)]))
	{
		[self addSubview:imageview];
		CGRect clickableFrame = CGRectMake(0, 0, 140, 100);
		ClickableView *newClickableView = [[ClickableView alloc] initWithFrame:clickableFrame];
		[newClickableView setTarget:theTarget];
		[newClickableView setSingleClickAction:theClickAction];
		[self setClickableView:newClickableView];
		[newClickableView release];
		[self addSubview:newClickableView];
	}
	return self;
}


-(void)setStatus:(NSString *)theStatus
{
	[text setText:theStatus];
}


-(void)dealloc
{
	NSLog(@"StatusBubble::dealloc");
	if (text.text)
	{
		[text.text release];
	}
	[text removeFromSuperview];
	[text release];
	[bubble removeFromSuperview];
	[bubble release];
	[self setClickableView:nil];
	[super dealloc];
}


@end
