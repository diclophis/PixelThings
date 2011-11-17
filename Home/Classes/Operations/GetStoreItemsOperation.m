// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "GetStoreItemsOperation.h"


@implementation GetStoreItemsOperation


@synthesize items;
@synthesize categoryId;


-(id)initWithCategoryId:(NSString *)theCategoryId {
	if ((self = [super init])) {
		[self setCategoryId:theCategoryId];
	}
	return self;
}


-(void)dealloc {
  [categoryId release];
	[items release];
	[super dealloc];
}


-(void)doOperation
{
	[self setItems:[client getStoreItems:categoryId]];
}


-(void)handleException:(id)theException
{
	[self setErrorMessage:@"Unable to fetch items!"];
}


@end
