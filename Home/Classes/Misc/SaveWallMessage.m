// GPL

#import "SaveWallMessage.h"


@implementation SaveWallMessage


@synthesize friendUsername;
@synthesize message;


-(id)initWithMessage:(NSString *)theMessage andFriendUsername:(NSString *)theFriendUsername {
	if ((self = [super init])) {
		[self setMessage:theMessage];
		[self setFriendUsername:theFriendUsername];
	}
	return self;
}

-(void)dealloc {
	[friendUsername release];
	[message release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client saveWallMessage:username :friendUsername :message]];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to save wall message, please try again"];
	}
}


@end
