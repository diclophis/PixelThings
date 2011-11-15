// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchFriendsRoomOperation : Operation {
	NSString *friendUsername;
	NSMutableArray *items;
	Score *score;
	Avatar *avatar;
}


@property (retain) NSString *friendUsername;
@property (retain) NSMutableArray *items;
@property (retain) Score *score;
@property (retain) Avatar *avatar;


-(id)initWithFriendUsername:(NSString *)theFriendUsername;


@end