// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SavePostOperation : Operation {
	NSInteger topicId;
	NSString *body;
}

@property NSInteger topicId;
@property (retain) NSString *body;


-(id)initWithTopicId:(NSInteger)theTopicId andBody:(NSString *)theBody;


@end