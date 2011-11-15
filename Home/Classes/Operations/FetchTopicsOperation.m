// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "PaginatedTopics.h"
#import "FetchTopicsOperation.h"


@implementation FetchTopicsOperation


@synthesize forumId;
@synthesize page;
@synthesize pager;


-(id)initWithForumId:(NSInteger)theForumId andPage:(NSInteger)thePage {
	if ((self = [super init])) {
		[self setForumId:theForumId];
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
			[self setPager:[client fetchTopics:forumId :page]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch topics, please try again"];
	}
}


@end