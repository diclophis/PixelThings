// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchTopicsOperation : Operation {
	NSInteger forumId;
	NSInteger page;
	PaginatedTopics *pager;
}


@property NSInteger forumId;
@property NSInteger page;
@property (retain) PaginatedTopics *pager;


-(id)initWithForumId:(NSInteger)theForumId andPage:(NSInteger)thePage;


@end