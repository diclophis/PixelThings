// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "SaveAvatarOperation.h"


@implementation SaveAvatarOperation


@synthesize myAvatar;


-(void)dealloc {
	[myAvatar release];
	[super dealloc];
}


-(id)initWithAvatar:(Avatar *)theAvatar {
	if ((self = [super init])) {
		[self setMyAvatar:theAvatar];
	}
	return self;
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setSuccess:[client saveAvatar:username :myAvatar]];
			if (success) {
			} else {
				[self setErrorMessage:@"Unable to update character, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error saving your character, please try again"];
	}
}


@end
