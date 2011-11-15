// GPL

#import "RemoveFriendOperation.h"


@implementation RemoveFriendOperation


@synthesize friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername {
	if ((self = [super init])) {
		[self setFriendUsername:theFriendUsername];
	}
	return self;
}


-(void)dealloc {
	[friendUsername release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client removeFriend:username :friendUsername]];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error removing your friend, please try again"];
	}
}


@end
