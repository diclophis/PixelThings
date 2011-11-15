// GPL

#import "SavePostOperation.h"

@implementation SavePostOperation


@synthesize topicId;
@synthesize body;


-(id)initWithTopicId:(NSInteger)theTopicId andBody:(NSString *)theBody { 
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Saving Post..."];
		[self setTopicId:theTopicId];
		[self setBody:theBody];
	}
	return self;
}


-(void)dealloc {
	[body release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			//[self setSuccess:[client savePost:username :topicId :body]];
		}
	}
	
	@catch (id theException) {
    /*
		if ([theException isKindOfClass:[RecordInvalid class]]) {
			[self setErrorMessage:[theException message]];
		} else {
			[self setErrorMessage:@"There was an error saving your post, please try again"];
		}
    */
	}
}

@end