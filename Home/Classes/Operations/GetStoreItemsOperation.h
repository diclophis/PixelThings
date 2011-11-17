// GPL

#import <Foundation/Foundation.h>
#import "SimpleOperation.h"


@interface GetStoreItemsOperation : SimpleOperation {
	NSArray *items;
	NSString *categoryId;
}


@property (retain) NSString *categoryId;
@property (retain) NSArray *items;


-(id)initWithCategoryId:(NSString *)theCategoryId;


@end
