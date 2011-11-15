// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchRecentVisitsOperation : Operation {
	PaginatedVisits *pager;
	NSInteger page;
}


@property (retain) PaginatedVisits *pager;
@property NSInteger page;


-(id)initWithPage:(NSInteger)thePage;
-(id)initWithUsername:(NSString *)theFriendUsername andPage:(NSInteger)thePage;


@end