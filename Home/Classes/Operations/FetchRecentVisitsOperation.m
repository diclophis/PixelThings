// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "PaginatedVisits.h"
#import "FetchRecentVisitsOperation.h"


@implementation FetchRecentVisitsOperation


@synthesize pager;
@synthesize page;


-(id)initWithUsername:(NSString *)theFriendUsername andPage:(NSInteger)thePage {
	if ((self = [super init])) {
		[self setUsername:theFriendUsername];
		[self setPage:thePage];
	}
	return self;
}


-(id)initWithPage:(NSInteger)thePage {	
	if ((self = [super init])) {
		[self setPage:thePage];
	}
	return self;
}


-(void)dealloc {
	[pager release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setPager:[client fetchRecentVisits:username :page]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch recent visits, please try again"];
	}
}


@end