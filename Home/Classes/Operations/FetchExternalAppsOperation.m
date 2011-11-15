// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "FetchExternalAppsOperation.h"


@implementation FetchExternalAppsOperation


@synthesize myExternalApps;


-(id)init {
	if ((self = [super init])) {
		[self setMyExternalApps:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[myExternalApps release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			NSArray *externalApps = [client fetchExternalApps:username];
			[self setMyExternalApps:[NSMutableArray arrayWithArray:externalApps]];
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch external apps, please try again"];
	}
	
	@finally {
		if (![self allDependenciesSuccessful] || [self isCancelled]) {
			[self setSuccess:NO];
		}
	}
}


@end
