// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "PaginatedWallItems.h"
#import "FetchRecentWallItemsOperation.h"


@implementation FetchRecentWallItemsOperation


@synthesize friendUsername;
@synthesize pager;
@synthesize page;


-(id)initWithFriendUsername:(NSString *)theFriendUsername andPage:(NSInteger)thePage {
	if ((self = [super init])) {
		[self setFriendUsername:theFriendUsername];
		[self setPage:thePage];
	}
	return self;
}


-(void)dealloc {
	[friendUsername release];
	[pager release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([super connect]) {
			BOOL mine = ([friendUsername isEqualToString:username] ? YES : NO);
			[self setPager:[client fetchRecentWallItems:friendUsername :page :mine]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch wall items, please try again"];
	}
}


@end