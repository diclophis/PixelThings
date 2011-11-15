// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "AddFriendOperation.h"


@implementation AddFriendOperation


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
			[self setSuccess:[client addFriend:username :friendUsername]];
			if (success) {
				[self setErrorMessage:[NSString stringWithFormat:@"Your friend request has been sent to %@", friendUsername]];
			} else {
				[self setErrorMessage:[NSString stringWithFormat:@"%@ does not exist", friendUsername]];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error adding friend, please try again"];
	}
}


@end
