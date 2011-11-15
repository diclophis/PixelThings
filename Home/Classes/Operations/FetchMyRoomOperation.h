// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchMyRoomOperation : Operation	{
	NSMutableArray *items;
}


@property (retain) NSMutableArray *items;


@end