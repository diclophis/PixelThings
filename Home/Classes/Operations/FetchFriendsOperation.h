// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchFriendsOperation : Operation {
	NSMutableDictionary *friends;

}

@property (nonatomic, retain) NSMutableDictionary *friends;

@end