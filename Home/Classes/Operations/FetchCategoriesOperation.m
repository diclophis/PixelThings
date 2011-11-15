// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "FetchCategoriesOperation.h"


@implementation FetchCategoriesOperation


@synthesize categories;


-(void)dealloc {
	[categories release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
      [self setCategories:[client getItemCategories]];
      [self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error fetching categories, please try again"];
	}
}


@end