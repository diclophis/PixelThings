// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchPostsOperation : Operation {
	NSString *topicId;
	NSInteger page;
	PaginatedPosts *pager;
}


@property (retain) NSString *topicId;
@property NSInteger page;
@property (retain) PaginatedPosts *pager;


-(id)initWithTopicId:(NSString *)theTopicId andPage:(NSInteger)thePage;


@end
