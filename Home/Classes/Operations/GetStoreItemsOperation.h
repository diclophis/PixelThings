// GPL

#import <Foundation/Foundation.h>
#import "SimpleOperation.h"


@interface GetStoreItemsOperation : SimpleOperation {
	NSArray *items;
	NSInteger categoryId;
}


@property NSInteger categoryId;
@property (retain) NSArray *items;


-(id)initWithCategoryId:(NSInteger)theCategoryId;


@end
