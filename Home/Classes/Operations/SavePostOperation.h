// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SavePostOperation : Operation {
	NSString *topicId;
	NSString *body;
}

@property (retain) NSString *topicId;
@property (retain) NSString *body;


-(id)initWithTopicId:(NSString *)theTopicId andBody:(NSString *)theBody;


@end
