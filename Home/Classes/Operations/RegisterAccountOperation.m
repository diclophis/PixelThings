// GPL


#import "Parse/parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "RegisterAccountOperation.h"


@implementation RegisterAccountOperation


@synthesize email;
@synthesize password;


-(id)initWithUsername:(NSString *)theUsername andEmail:(NSString *)theEmail andPassword:(NSString *)thePassword {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Registering..."];
		[self setUsername:theUsername];
		[self setEmail:theEmail];
		[self setPassword:thePassword];
	}
	return self;
}


-(void)dealloc {
	[email release];
	[password release];
	[super dealloc];
}


-(void)main {
	@try {
    if ([self connect]) {
      if ([client registerAccount :username :email :password]) {
        [self setDflts:[NSUserDefaults standardUserDefaults]];
        [dflts setObject:username forKey:@"Account.JID"];
        [dflts setObject:password forKey:@"Account.Password"];
        [dflts setObject:email forKey:@"Account.Email"];
        [dflts synchronize];
        [self setSuccess:YES];
      }
    }
	}
	
	@catch (id theException) {
        NSLog(@"theException: %@", theException);
	}
}


@end
