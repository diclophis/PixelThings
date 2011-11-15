// GPL

#import "GetImageUrlOperation.h"
//#import "protocol.h"

@implementation GetImageUrlOperation

@synthesize name;
@synthesize url;

-(GetImageUrlOperation*)initWithName:(NSString *)theName
{
	if (self = [super init])
	{
		[self setName:theName];
	}
	return self;
}

-(void)doOperation
{
  /*
	[self setUrl: [client getImageUrl:name]];
  */
}

-(void)handleException:(id)theException
{
	[self setErrorMessage:@"Error!"];
}

-(void)dealloc
{
	[url release];
	[self setName:nil];
	[super dealloc];
}
@end
