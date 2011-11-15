// GPL

#import "LikeRoomOperation.h"
//#import "protocol.h"


@implementation LikeRoomOperation


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
      /*
			[self setSuccess:[client likeRoom:username :friendUsername]];
			if (success) {
			} else {
				[self setErrorMessage:@"Unable to like room, please try again"];
			}
      */
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error liking your room, please try again"];
	}
}


@end
