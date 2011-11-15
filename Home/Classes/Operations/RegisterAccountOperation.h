// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface RegisterAccountOperation : Operation {
	NSString *email;
	NSString *password;
}


@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *password;


-(id)initWithUsername:(NSString *)theUsername andEmail:(NSString *)theEmail andPassword:(NSString *)thePassword;


@end
