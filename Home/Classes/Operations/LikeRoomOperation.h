// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface LikeRoomOperation : Operation {
	NSString *friendUsername;
}


@property (retain) NSString *friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername;


@end
