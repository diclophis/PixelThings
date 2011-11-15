// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "DoCharacterAnimationOperation.h"

@implementation DoCharacterAnimationOperation

-(void)doOperation
{
	BOOL doAction = [client doCharacterAnimation:username];
	if (!doAction)
	{
		@throw [NSException exceptionWithName:@"error saving points for character animation" reason:nil userInfo:nil];
	}
}


-(void)handleException:(id)theException
{
	[self setErrorMessage:@"Unable to save points, please try again"];
}


@end
