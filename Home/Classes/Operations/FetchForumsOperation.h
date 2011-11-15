// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchForumsOperation : Operation {
	NSArray *forums;
	NSArray *chatrooms;
}


@property (retain) NSArray *forums;
@property (retain) NSArray *chatrooms;


@end