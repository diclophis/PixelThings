// GPL

#import <Foundation/Foundation.h>
#import "operation.h"


@interface InteractWithFriendOperation : Operation {
	NSString *friendUsername;
	NSString *interaction;
}


@property (retain) NSString *friendUsername;
@property (retain) NSString *interaction;


-(id)initWithFriendUsername:(NSString *)theFriendUsername andInteraction:(NSString *)theInteraction;


@end