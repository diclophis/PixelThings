// GPL

#import "SendInviteOperation.h"


@implementation SendInviteOperation


@synthesize email;
@synthesize message;


-(id)initWithEmail:(NSString *)theEmail andMessage:(NSString *)theMessage {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Sending invite..."];
		[self setEmail:theEmail];
		if ([theMessage length] > 0) {
			[self setMessage:theMessage];
		}
	}
	return self;
}


-(void)dealloc {
	[email release];
	[message release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client sendInvite:username :email :message]];
			if (success) {
			} else {
				[self setErrorMessage:@"Unable to send invite, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error sending invite, please try again"];
	}
}


@end
