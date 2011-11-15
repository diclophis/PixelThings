// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Score.h"
#import "FetchScoreOperation.h"


@implementation FetchScoreOperation


@synthesize score;


-(id)init {
	if ((self = [super init])) {

	}
	return self;
}


-(void)dealloc {
	[score release];
	[super dealloc];
}


-(void)main {
	@try {
		if ([self connect]) {
			[self setScore:[client fetchScore:username]];
			if (score) {
				[self setSuccess:YES];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch points, don't worry your points are safe"];
	}
}


@end