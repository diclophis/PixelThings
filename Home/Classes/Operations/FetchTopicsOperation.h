// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchTopicsOperation : Operation {
	NSString *forumId;
	NSInteger page;
	PaginatedTopics *pager;
}


@property (retain) NSString *forumId;
@property NSInteger page;
@property (retain) PaginatedTopics *pager;


-(id)initWithForumId:(NSString *)theForumId andPage:(NSInteger)thePage;


@end
