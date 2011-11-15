// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveWallMessage : Operation {
	NSString *friendUsername;
	NSString *message;
}


@property (retain) NSString *friendUsername;
@property (retain) NSString *message;


-(id)initWithMessage:(NSString *)theMessage andFriendUsername:(NSString *)theFriendUsername;


@end
