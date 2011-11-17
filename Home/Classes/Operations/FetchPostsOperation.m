// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "PaginatedPosts.h"
#import "FetchPostsOperation.h"


@implementation FetchPostsOperation


@synthesize topicId;
@synthesize page;
@synthesize pager;


-(id)initWithTopicId:(NSString *)theTopicId andPage:(NSInteger)thePage {
	if ((self = [super init])) {
		[self setTopicId:theTopicId];
		[self setPage:thePage];
	}
	return self;
}


-(void)dealloc {
  [topicId release];
	[pager release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setPager:[client fetchPosts:topicId :page]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch posts, please try again"];
	}
}


@end
