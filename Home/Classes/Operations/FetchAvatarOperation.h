// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchAvatarOperation : Operation {
	Avatar *avatar;
}


@property (retain) Avatar *avatar;


@end
