// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "SavePostOperation.h"

@implementation SavePostOperation


@synthesize topicId;
@synthesize body;


-(id)initWithTopicId:(NSString *)theTopicId andBody:(NSString *)theBody { 
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Saving Post..."];
		[self setTopicId:theTopicId];
		[self setBody:theBody];
	}
	return self;
}


-(void)dealloc {
  [topicId release];
	[body release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setSuccess:[client savePost:username :topicId :body]];
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error saving your post, please try again"];
	}
}

@end
