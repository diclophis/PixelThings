// GPL

#import "Operation.h"
#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Avatar.h"
#import "Forum.h"
#import "FunItem.h"
#import "ItemCategory.h"
#import "Like.h"
#import "PaginatedLikes.h"
#import "PaginatedPosts.h"
#import "PaginatedTopics.h"
#import "PaginatedVisits.h"
#import "PaginatedWallItems.h"
#import "Post.h"
#import "RoomItem.h"
#import "Score.h"
#import "Topic.h"
#import "Visit.h"
#import "WallItem.h"
#import "Friend.h"
#import "Character.h"
#import "ParseClient.h"


@implementation Operation


@synthesize progress;
@synthesize success;
@synthesize hasDelegate;
@synthesize indicatesProgress;
@synthesize operationDescription;
@synthesize errorMessage;
@synthesize recoverable;
@synthesize username;
@synthesize deviceIdentifier;
@synthesize dflts;
@synthesize client;


-(id)init {
	if ((self = [super init])) {
		[self setOperationDescription:@""];
		[self setSuccess:NO];
		[self setIndicatesProgress:NO];
		[self setRecoverable:YES];
		[self setProgress:[NSNumber numberWithFloat:0.0f]];
		[self setDflts:[NSUserDefaults standardUserDefaults]];
		[self setUsername:[dflts objectForKey:@"Account.JID"]];
		[self setDeviceIdentifier:[[UIDevice currentDevice] uniqueIdentifier]];
	}
	return self;
}


-(void)dealloc {	
	[self setProgress:nil];
	[self setOperationDescription:nil];
	[self setErrorMessage:nil];
	[self setUsername:nil];
	[self setDflts:nil];
	[self setDeviceIdentifier:nil];
  [self setClient:nil];
	[super dealloc];
}


-(BOOL)connect {
	if (![self allDependenciesSuccessful] || [self isCancelled]) {
		return NO;
	}
  
  client = [[ParseClient alloc] init];
  
	return YES;
}


-(BOOL)allDependenciesSuccessful {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSEnumerator *enumerator = [[self dependencies] objectEnumerator];
	Operation *dependency;
	while ((dependency = [enumerator nextObject])) {
		if (![dependency success]) {
			[pool drain];
			return NO;
		}
	}
	[pool drain];
	return YES;
}


-(void)abortOperation:(id)userData {
	if ([self isFinished]) {
		//keep going
	} else {
		[self cancel];
	}
}



@end