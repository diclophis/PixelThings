// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveTopicOperation : Operation {
	NSString *forumId;
	NSString *title;
}

@property (retain) NSString *forumId;
@property (retain) NSString *title;


-(id)initWithForumId:(NSString *)theForumId andTitle:(NSString *)theTitle;


@end
