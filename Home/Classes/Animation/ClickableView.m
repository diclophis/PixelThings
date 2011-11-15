// GPL


#import "ClickableView.h"
#import "PointObject.h"

@implementation ClickableView


@synthesize target;
@synthesize singleClickAction;
@synthesize doubleClickAction;
@synthesize dragAction;


-(ClickableView *)init {
	if ((self = [super init])) {
		[self setTarget:nil];
		[self setSingleClickAction:NULL];
		[self setDoubleClickAction:NULL];
		[self setDragAction:NULL];
		[self setBackgroundColor:[UIColor cyanColor]];
	}
	return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if ([self isHandled:touches])
	{
		for (UITouch *touch in [touches allObjects])
		{
			if ([touch tapCount] == 1 && singleClickAction != NULL)
			{
				[self performSelector:@selector(handleSingleClick) withObject:nil afterDelay:0.25];
			}
			else if ([touch tapCount] == 2 && doubleClickAction != NULL)
			{
				if (doubleClickAction != NULL)
				{
					[target performSelector:doubleClickAction];
				}
			}
		}
	}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([self isHandled:touches])
	{
		for (UITouch *touch in [touches allObjects])
		{
			CGPoint newLocation = [touch locationInView:self];
			float dx = newLocation.x - startLocation.x;
			float dy = newLocation.y - startLocation.y;
			PointObject *point = [PointObject pointObjectWithX:dx andY:dy];
			if (dragAction != NULL)
			{
				[target performSelector:dragAction withObject:point];
			}
		}
	}
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	if ([self isHandled:touches])
	{
		for (UITouch *touch in [touches allObjects])
		{
			startLocation = [touch locationInView:self];
			if ([touch tapCount] == 2)
			{
				[NSObject cancelPreviousPerformRequestsWithTarget:self];
			}
		}
	}
}


-(void)handleSingleClick
{
	[target performSelector:singleClickAction];
}


-(BOOL)isHandled:(NSSet *)touches
{
	return target != nil && [touches count] == 1;
}


- (void)dealloc {
    [super dealloc];
}


@end