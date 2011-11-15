// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchRecentWallItemsOperation : Operation {
	NSString *friendUsername;
	PaginatedWallItems *pager;
	NSInteger page;

}


@property (retain) NSString *friendUsername;
@property (retain) PaginatedWallItems *pager;
@property NSInteger page;


-(id)initWithFriendUsername:(NSString *)theFriendUsername andPage:(NSInteger)thePage;


@end