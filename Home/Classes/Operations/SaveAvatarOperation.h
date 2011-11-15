// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveAvatarOperation : Operation {
	Avatar *myAvatar;
}


@property (retain) Avatar *myAvatar;


-(id)initWithAvatar:(Avatar *)theAvatar;


@end
