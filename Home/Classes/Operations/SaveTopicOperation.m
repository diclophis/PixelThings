// GPL

#import "SaveTopicOperation.h"


@implementation SaveTopicOperation


@synthesize title;
@synthesize forumId;


-(id)initWithForumId:(NSInteger)theForumId andTitle:(NSString *)theTitle {
	if ((self = [super init])) {
		[self setTitle:theTitle];
		[self setForumId:theForumId];
	}
	return self;
}


-(void)dealloc {
	[title release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client saveTopic:username :forumId :title]];
		}
	}
	
	@catch (id theException) {
    /*
		if ([theException isKindOfClass:[RecordInvalid class]]) {
			[self setErrorMessage:[theException message]];
		} else {
			[self setErrorMessage:@"There was an error saving topic, please try again"];
		}
    */
	}
}




@end
