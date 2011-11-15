// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "FetchFriendsOperation.h"


@implementation FetchFriendsOperation


@synthesize friends;


-(id)init {
	if ((self = [super init])) {
		[self setFriends:[NSMutableDictionary dictionaryWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[friends release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			NSArray *fetchedFriends = [client fetchFriends:username];
			for (Friend *fetchedFriend in fetchedFriends) {
				NSMutableDictionary *friend = [NSMutableDictionary dictionaryWithCapacity:0];
				[friend setObject:[fetchedFriend status] forKey:@"status"];
				[friend setObject:[NSString stringWithFormat:@"%d", [fetchedFriend online]] forKey:@"online"];
				[friends setObject:friend forKey:[fetchedFriend username]];
			}
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch friends, please try again"];
	}
}

@end