// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Item.h"
#import "FetchFriendsRoomOperation.h"


@implementation FetchFriendsRoomOperation


@synthesize friendUsername;
@synthesize items;
@synthesize score;
@synthesize avatar;


-(id)initWithFriendUsername:(NSString *)theFriendUsername {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setFriendUsername:theFriendUsername];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[avatar release];
	[score release];
	[friendUsername release];
	[items release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			NSArray *theThriftItems = [client fetchRoom:friendUsername];
			[self setScore:[client fetchScore:friendUsername]];
			[self setAvatar:[client fetchAvatar:friendUsername]];
			BOOL visited = [client visitRoom:username :friendUsername];
			if (theThriftItems && score && visited) {
				for (ViewableRoomItem *thriftItem in theThriftItems) {
					Item *item = [[Item alloc] initWithItemId:[thriftItem itemId] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]];
          //initWithCategoryKey:[thriftItem categoryKey] andItemKey:[thriftItem itemKey] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]];
					[item setCenter:CGPointMake([thriftItem x], [thriftItem y] - 200.0f)];
					[items addObject:item];
				}
				[self setSuccess:YES];
			} else {
				[self setErrorMessage:@"Unable to fetch your friends room, please try again"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error fetching your friend's room, please try again"];
	}
}


@end