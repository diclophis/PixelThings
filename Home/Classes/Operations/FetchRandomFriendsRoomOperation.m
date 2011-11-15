// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Score.h"
#import "Avatar.h"
#import "Item.h"
#import "FetchRandomFriendsRoomOperation.h"


@implementation FetchRandomFriendsRoomOperation


@synthesize friendUsername;
@synthesize items;
@synthesize score;
@synthesize avatar;


-(id)init {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Going to neighbors room..."];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[avatar release];
	[friendUsername release];
	[items release];
	[score release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			Friend *thriftFriend = [client randomFriend:username];		
			[self setScore:[client fetchScore:[thriftFriend username]]];
			[self setAvatar:[client fetchAvatar:[thriftFriend username]]];
			[client visitRoom:username :[thriftFriend username]];
			NSArray *theThriftItems = [client fetchRoom:[thriftFriend username]];
			for (ViewableRoomItem *thriftItem in theThriftItems) {
				Item *item = [[Item alloc] initWithItemId:[thriftItem itemId] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]]; //initWithCategoryKey:[thriftItem categoryKey] andItemKey:[thriftItem itemKey] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]];
				[item setCenter:CGPointMake([thriftItem x], [thriftItem y] - 200.0f)];
				[items addObject:item];
			}
			[self setSuccess:YES];
		}
	}
	
	@catch (id theException) {
    [self setErrorMessage:@"There was an error fetching neighbor, please try again"];
	}
}


@end
