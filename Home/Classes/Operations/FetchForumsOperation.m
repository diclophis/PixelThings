// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "FetchForumsOperation.h"

@implementation FetchForumsOperation


@synthesize forums;
@synthesize chatrooms;


-(id)init {
	if ((self = [super init])) {
		[self setForums:[NSMutableArray arrayWithCapacity:0]];
		[self setChatrooms:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[forums release];
	[chatrooms release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setForums:[client fetchForums]];
			[self setChatrooms:[client fetchChatrooms]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch forums/chatrooms, please try again"];
	}
}


@end