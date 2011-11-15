// GPL

#import "InteractWithFriendOperation.h"
//#import "protocol.h"

@implementation InteractWithFriendOperation


@synthesize friendUsername;
@synthesize interaction;


-(void)dealloc {
	[friendUsername release];
	[interaction release];
	[super dealloc];
}


-(id)initWithFriendUsername:(NSString *)theFriendUsername andInteraction:(NSString *)theInteraction {
	if ((self = [super init])) {
		[self setFriendUsername:theFriendUsername];
		[self setInteraction:theInteraction];
	}
	return self;
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client interactWithFriend:username :friendUsername :interaction]];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error saving points, don't worry though"];
	}
}


@end