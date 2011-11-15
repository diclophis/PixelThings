// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Avatar.h"
#import "FetchAvatarOperation.h"


@implementation FetchAvatarOperation


@synthesize avatar;


-(void)dealloc {
	[avatar release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setAvatar:[client fetchAvatar:username]];
			if (avatar) {
				[self setSuccess:YES];
			} else {
				[self setErrorMessage:@"Unable to fetch character, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error fetching your character, please try again"];
	}
}


@end
