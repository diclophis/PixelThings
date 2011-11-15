// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface RemoveFriendOperation : Operation {
	NSString *friendUsername;
}


@property (nonatomic, retain) NSString *friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername;


@end
