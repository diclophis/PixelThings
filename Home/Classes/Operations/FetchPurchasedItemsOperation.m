// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Item.h"
#import "FetchPurchasedItemsOperation.h"


@implementation FetchPurchasedItemsOperation


@synthesize items;
@synthesize categoryDescription;


-(id)initWithCategoryDescription:(NSString *)theCategoryDescription {
	if ((self = [super init])) {
		[self setCategoryDescription:theCategoryDescription];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[categoryDescription release];
	[items release];
	[super dealloc];
}


-(void)main {
	@try {
		if ([self connect]) {
			NSArray *theThriftItems = [client fetchPurchasedItems:username :categoryDescription];	
			for (FunItem *funItem in theThriftItems) {		
				Item *item = [[Item alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0, 75.0)];
				[item setItemId:[funItem id] andFilename:[funItem filename] andVariations:[funItem variations] andFrames:[funItem frames] andConstrained:[funItem constrained] andCurrentVariation:0];
				[items addObject:item];
			}
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch your purchased items, please try again"];
	}
	
	@finally {
		if (![self allDependenciesSuccessful] || [self isCancelled]) {
			[self setSuccess:NO];
		}
	}
}


@end