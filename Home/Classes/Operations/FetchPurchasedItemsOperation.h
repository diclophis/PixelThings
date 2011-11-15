// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchPurchasedItemsOperation : Operation {
	NSMutableArray *items;
	NSString *categoryDescription;
}


@property (retain) NSMutableArray *items;
@property (retain) NSString *categoryDescription;


-(id)initWithCategoryDescription:(NSString *)theCategoryDescription;


@end
