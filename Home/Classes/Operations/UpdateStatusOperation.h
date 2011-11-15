// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface UpdateStatusOperation : Operation {
	NSString *status;
}


@property (retain) NSString *status;


-(id)initWithStatus:(NSString *)theStatus;


@end
