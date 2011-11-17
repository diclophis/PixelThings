// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "SaveTopicOperation.h"


@implementation SaveTopicOperation


@synthesize title;
@synthesize forumId;


-(id)initWithForumId:(NSString *)theForumId andTitle:(NSString *)theTitle {
	if ((self = [super init])) {
		[self setTitle:theTitle];
		[self setForumId:theForumId];
	}
	return self;
}


-(void)dealloc {
  [forumId release];
	[title release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setSuccess:[client saveTopic:username :forumId :title]];
		}
	}
	
	@catch (id theException) {
	  [self setErrorMessage:@"There was an error saving topic, please try again"];
	}
}




@end
