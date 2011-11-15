// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "PaginatedLikes.h"
#import "FetchRecentLikesOperation.h"


@implementation FetchRecentLikesOperation


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
			[self setPager:[client fetchRecentLikes:username :page]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch recent likes, please try again"];
	}
}



@end