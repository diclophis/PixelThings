// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "FetchCharacterOperation.h"


@implementation FetchCharacterOperation


@synthesize character;


-(void)dealloc {
	[character release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setCharacter:[client fetchCharacter:username]];
			if (character) {
				[self setSuccess:YES];
			} else {
				[self setErrorMessage:@"Unable to fetch character, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error fetching your character, please try again"];
	}
}


@end
