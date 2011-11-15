// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchRecentLikesOperation : Operation {
	PaginatedLikes *pager;
	NSInteger page;
}


@property (retain) PaginatedLikes *pager;
@property NSInteger page;


-(id)initWithPage:(NSInteger)thePage;
-(id)initWithUsername:(NSString *)theFriendUsername andPage:(NSInteger)thePage;


@end
