// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchPostsOperation : Operation {
	NSInteger topicId;
	NSInteger page;
	PaginatedPosts *pager;
}


@property NSInteger topicId;
@property NSInteger page;
@property (retain) PaginatedPosts *pager;


-(id)initWithTopicId:(NSInteger)theTopicId andPage:(NSInteger)thePage;


@end