// GPL

#import "UpdateStatusOperation.h"
//#import "protocol.h"


@implementation UpdateStatusOperation


@synthesize status;


-(id)initWithStatus:(NSString *)theStatus {
	if ((self = [super init])) {
		[self setStatus:theStatus];
	}
	return self;
}


-(void)dealloc {
	[status release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client updateStatus:username :status]];
			if (success) {
			} else {
				[self setErrorMessage:@"Unable to update status, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error updating your status, please try again"];
	}
}


@end
