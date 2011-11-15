// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "GetStoreItemsOperation.h"


@implementation GetStoreItemsOperation


@synthesize items;
@synthesize categoryId;


-(id)initWithCategoryId:(NSInteger)theCategoryId {
	if ((self = [super init])) {
		[self setCategoryId:theCategoryId];
	}
	return self;
}


-(void)dealloc {
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
