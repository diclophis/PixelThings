// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SendInviteOperation : Operation {
	NSString *email;
	NSString *message;
}


@property (retain) NSString *email;
@property (retain) NSString *message;


-(id)initWithEmail:(NSString *)theEmail andMessage:(NSString *)theMessage;


@end
