// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Item.h"
#import "FetchMyRoomOperation.h"


@implementation FetchMyRoomOperation


@synthesize items;


-(id)init {
	if ((self = [super init])) {
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[items release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			NSArray *theThriftItems = [client fetchRoom:username];
			for (ViewableRoomItem *thriftItem in theThriftItems) {
				Item *item = [[Item alloc] initWithItemId:[thriftItem itemId] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]]; //initWithCategoryKey:[thriftItem categoryKey] andItemKey:[thriftItem itemKey] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]];
				[item setCenter:CGPointMake([thriftItem x], [thriftItem y] - 200.0f)];
				[items addObject:item];
			}
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"Unable to fetch your room, please try again"];
	}
}


@end