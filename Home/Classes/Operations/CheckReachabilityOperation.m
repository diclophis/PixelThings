// GPL


#import <SystemConfiguration/SCNetworkReachability.h>
#import "CheckReachabilityOperation.h"


@implementation CheckReachabilityOperation


-(id)init {
	if ((self = [super init])) {
		[self setOperationDescription:@"Checking connectivity..."];
	}
	return self;
}


-(id)initWithoutDescription {
	if ((self = [super init])) {
	}
	return self;
}


-(void)dealloc {
	[super dealloc];
}


-(void)main {
	BOOL gotFlags;    
	const char *host_name = "google.com";
	SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithName(NULL, host_name);
	SCNetworkReachabilityFlags flags;
	gotFlags = SCNetworkReachabilityGetFlags(reachability, &flags);
	[self setSuccess:gotFlags && (flags & kSCNetworkFlagsReachable) && !(flags & kSCNetworkFlagsConnectionRequired)];
	CFRelease(reachability);
}


@end