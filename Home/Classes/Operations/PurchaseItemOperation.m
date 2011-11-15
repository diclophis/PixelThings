// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "FunItem.h"
#import "PurchaseItemOperation.h"


@implementation PurchaseItemOperation


@synthesize item;


-(id)initWithItem:(FunItem *)theItem {
	if ((self = [super init])) {
		[self setItem:theItem];
	}
	return self;
}


-(void)dealloc {
	[item release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client purchaseItem:username :[item id] :1]];
		}
	}
	
	@catch (id theException) {
    /*
		if ([theException isKindOfClass:[NotEnoughPoints class]]) {
			[self setErrorMessage:@"You do not have enough points"];
		} else if ([theException isKindOfClass:[NotEnoughQuantityAvailable class]]) {
			[self setErrorMessage:@"Sold out, try again tomorrow"];
		} else if ([theException isKindOfClass:[NegativeQuantity class]]) {
			[self setErrorMessage:@"There was an error purchasing item, please try again"];
		} else if ([theException isKindOfClass:[OverLimit class]]) {
			[self setErrorMessage:@"You have all ready purchased this item"];
		} else {
			[self setErrorMessage:@"Unable to complete transaction, please try again"];
		}
    */
	}
}


@end