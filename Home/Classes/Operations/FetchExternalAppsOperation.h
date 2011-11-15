// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchExternalAppsOperation : Operation {
	NSMutableArray *myExternalApps;
}


@property (retain) NSMutableArray *myExternalApps;


@end