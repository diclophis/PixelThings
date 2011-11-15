// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"

@interface AddFriendOperation : Operation {

	NSString *friendUsername;
}



@property (nonatomic, retain) NSString *friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername;


@end
