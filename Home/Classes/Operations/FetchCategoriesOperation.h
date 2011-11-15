// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchCategoriesOperation : Operation {
	NSArray *categories;
}


@property (retain) NSArray *categories;


@end