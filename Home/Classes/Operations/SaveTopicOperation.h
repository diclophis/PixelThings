// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveTopicOperation : Operation {
	NSInteger forumId;
	NSString *title;
}

@property NSInteger forumId;
@property (retain) NSString *title;


-(id)initWithForumId:(NSInteger)theForumId andTitle:(NSString *)theTitle;


@end
