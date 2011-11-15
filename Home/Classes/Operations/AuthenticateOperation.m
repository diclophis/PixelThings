// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"

#import "AuthenticateOperation.h"
#import "AnimationSystem.h"


@implementation AuthenticateOperation


@synthesize password;
@synthesize items;
@synthesize friends;
@synthesize avatar;
@synthesize score;
@synthesize deviceToken;


-(id)init {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setPassword:[dflts objectForKey:@"Account.Password"]];
		[self setDeviceToken:[dflts objectForKey:@"Account.DeviceToken"]];
		[self setOperationDescription:@"Authenticating..."];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
		[self setFriends:[NSMutableDictionary dictionaryWithCapacity:0]];
	}
	return self;
}


-(void)dealloc {
	[deviceToken release];
	[password release];
	[score release];
	[avatar release];
	[friends release];
	[items release];
	[super dealloc];
}


-(void)main {
	@try {
		if ([self connect]) {
			if ([client authenticateWithVersion:username :password :deviceToken :deviceIdentifier :@"Free"]) {
				[self setScore:[client fetchScore:username]];
				[self setAvatar:[client fetchAvatar:username]];
        /*
				NSArray *thriftFriends = [client fetchFriends:username];
				NSArray *theThriftItems = [client fetchRoom:username];

				for (Friend *thriftFriend in thriftFriends) {
					NSMutableDictionary *friend = [NSMutableDictionary dictionaryWithCapacity:0];
					[friend setObject:[thriftFriend status] forKey:@"status"];
					[friend setObject:[NSString stringWithFormat:@"%d", [thriftFriend online]] forKey:@"online"];
					[friends setObject:friend forKey:[thriftFriend username]];
				}
				
				for (ViewableRoomItem *thriftItem in theThriftItems) {
					Item *item = [[Item alloc] initWithItemId:[thriftItem itemId] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]]; //initWithCategoryKey:[thriftItem categoryKey] andItemKey:[thriftItem itemKey] andFilename:[thriftItem filename] andVariations:[thriftItem variations] andFrames:[thriftItem frames] andConstrained:[thriftItem constrained] andCurrentVariation:[thriftItem currentVariation]];
					[item moveTo:CGPointMake([thriftItem x], [thriftItem y] - 200.0f)];
					[items addObject:item];
				}
        */
        [AnimationSystem initializeAvatarSelection];
				[self setSuccess:YES];
			} else {
				[self setErrorMessage:@"The nickname and or password you entered is invalid, please try again"];
			}
      
		}
	}
	
	
	@catch (id theException) {
		//TODO better handling of odd errors here
		NSLog(@"theAuthenticateException: %@", theException);
		[self setErrorMessage:@"Connection timed out, please try again!"];
		[self setRecoverable:NO];
	}
}


@end