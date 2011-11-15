// GPL

#import "SimpleOperation.h"


@implementation SimpleOperation

-(void)main {
	@try {
		if ([self connect]) {
			[self doOperation];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		NSLog(@"exception in simple operation %@", theException);
		[self handleException:theException];
	}
}

-(void)doOperation
{
}

-(void)handleException:(id)theException
{
}


@end
