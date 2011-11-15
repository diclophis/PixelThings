// GPL

#import "PointObject.h"


@implementation PointObject

@synthesize point;


-(void)dealloc {
	[super dealloc];
}


-(PointObject *)initWithPoint:(CGPoint)thePoint
{
	if (self = [super init])
	{
		[self setPoint:thePoint];
	}
	return self;
}

+(PointObject *)pointObjectWithX:(CGFloat)x andY:(CGFloat)y
{
	return [[[PointObject alloc] initWithPoint:CGPointMake(x, y)] autorelease];
}

@end
