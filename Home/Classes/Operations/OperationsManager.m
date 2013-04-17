// GPL


#import <Foundation/Foundation.h>
#import "Parse/Parse.h"
#import "OperationsManager.h"
#import "Reachability.h"
#import "CheckReachabilityOperation.h"
#import "SaveToPhotoAlbumOperation.h"
#import "AnimatedPerson.h"
#import "RegisterAccountOperation.h"
#import "AuthenticateOperation.h"
#import "AddFriendOperation.h"
#import "FetchFriendsOperation.h"
#import "FetchScoreOperation.h"
#import "RemoveFriendOperation.h"
#import "UpdateStatusOperation.h"
#import "SendInviteOperation.h"
#import "SaveRoomOperation.h"
#import "LikeRoomOperation.h"
#import "FetchFriendsRoomOperation.h"
#import "FetchRandomFriendsRoomOperation.h"
#import "FetchRecentWallItemsOperation.h"
#import "FetchForumsOperation.h"
#import "FetchTopicsOperation.h"
#import "SaveTopicOperation.h"
#import "FetchPostsOperation.h"
#import "SavePostOperation.h"
#import "FetchMyRoomOperation.h"
#import "DoCharacterAnimationOperation.h"
#import "SaveWallMessage.h"
#import "FetchRecentLikesOperation.h"
#import "FetchRecentVisitsOperation.h"
#import "GetStoreItemsOperation.h"
#import "FetchCategoriesOperation.h"
#import "PurchaseItemOperation.h"
#import "FetchPurchasedItemsOperation.h"
#import "FetchExternalAppsOperation.h"
#import "FetchAvatarOperation.h"
#import "SaveAvatarOperation.h"
#import "InteractWithFriendOperation.h"
#import "FetchImagesOperation.h"


static OperationsManager *operationsManagerInstance = NULL;


@implementation OperationsManager


@synthesize queue;
@synthesize executingDelegate;
@synthesize avatarViewingDelegate;
@synthesize remoteHostStatus;
@synthesize internetConnectionStatus;
@synthesize localWiFiConnectionStatus;
@synthesize invitingDelegate;
@synthesize fbSession;
@synthesize wallDelegate;
@synthesize topicsDelegate;
@synthesize postsDelegate;
@synthesize likesDelegate;
@synthesize visitsDelegate;
@synthesize storeDelegate;
@synthesize storeItemsDelegate;
@synthesize roomEditingDelegate;
@synthesize externalAppsDelegate;
@synthesize itemDownloaderDelegate;


+(OperationsManager *)sharedInstance {
  @synchronized(self) {
    if (operationsManagerInstance == NULL) {
      operationsManagerInstance = [[self alloc] init];
    }
  }
  return operationsManagerInstance;
}


-(id)init {
	if ((self = [super init])) {
		NSOperationQueue *theQueue = [[NSOperationQueue alloc] init];
		[self setQueue:theQueue];
		[theQueue release];
		[queue setMaxConcurrentOperationCount:1];
	}
	return self;
}


-(void)authenticate {
	[self makeAuthenticateOperation];
}


-(id)makeUpdateStatusOperation:(NSString *)theStatus {
	UpdateStatusOperation *updateStatus = [[UpdateStatusOperation alloc] initWithStatus:theStatus];
	[updateStatus addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[updateStatus addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	return [updateStatus autorelease];	 
}


-(void)updateStatus:(NSString *)theStatus {
	UpdateStatusOperation *updateStatus = [self makeUpdateStatusOperation:theStatus];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:updateStatus];
	[queue addOperation:fetch];
	[queue addOperation:updateStatus];
}


-(void)saveToPhotoAlbum:(CALayer *)layer {
	[executingDelegate willBeginPublishing];
	SaveToPhotoAlbumOperation *saveAvatar = [[SaveToPhotoAlbumOperation alloc] initWithLayer:layer];
	[saveAvatar addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:saveAvatar];
	[saveAvatar autorelease];
}


-(void)fetchFriendsRoom:(NSString *)theFriendUsername {
	FetchFriendsRoomOperation *fetchFriendsRoom = [[FetchFriendsRoomOperation alloc] initWithFriendUsername:theFriendUsername];
	[fetchFriendsRoom addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[fetchFriendsRoom addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:fetchFriendsRoom];
	[queue addOperation:fetch];
	[queue addOperation:fetchFriendsRoom];
	[fetchFriendsRoom autorelease];
}


-(void)fetchRandomFriendsRoom {
	FetchRandomFriendsRoomOperation *fetchRandomFriendsRoom = [[FetchRandomFriendsRoomOperation alloc] init];
	[fetchRandomFriendsRoom addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[fetchRandomFriendsRoom addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:fetchRandomFriendsRoom];
	[queue addOperation:fetch];
	[queue addOperation:fetchRandomFriendsRoom];
	[fetchRandomFriendsRoom autorelease];
}


-(void)checkReachability {
	[self makeCheckReachabilityOperation];
}


-(id)makeCheckReachabilityOperation {
	CheckReachabilityOperation *checkReachabilityOperation = [[CheckReachabilityOperation alloc] init];
	[checkReachabilityOperation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [checkReachabilityOperation autorelease];
}


-(id)makeCheckReachabilityOperationWithoutDescription {
	CheckReachabilityOperation *checkReachabilityOperation = [[CheckReachabilityOperation alloc] initWithoutDescription];
	[checkReachabilityOperation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [checkReachabilityOperation autorelease];
}


-(id)makeAuthenticateOperation {
	CheckReachabilityOperation *checkReachability = [self makeCheckReachabilityOperation];
	AuthenticateOperation *authenticateOperation = [[AuthenticateOperation alloc] init];
	[authenticateOperation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[authenticateOperation addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	[authenticateOperation addDependency:checkReachability];
	FetchForumsOperation *fetchForums = [self makeFetchForumsOperation];
	[fetchForums addDependency:authenticateOperation];
	[queue addOperation:fetchForums];
	[queue addOperation:authenticateOperation];
	[queue addOperation:checkReachability];
	return [authenticateOperation autorelease];
}


-(id)makeFetchMyRoomOperation {
	FetchMyRoomOperation *fetchMyRoom = [[FetchMyRoomOperation alloc] init];
	[fetchMyRoom addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [fetchMyRoom autorelease];
}


-(id)makeFetchScoreOpertion {
	FetchScoreOperation *fetchScore = [[FetchScoreOperation alloc] init];
	[fetchScore addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [fetchScore autorelease];
}


-(id)makeFetchFriendsOperation {
	FetchFriendsOperation *fetchFriends = [[FetchFriendsOperation alloc] init];
	[fetchFriends addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [fetchFriends autorelease];
}


-(void)registerUsername:(NSString *)username andEmail:(NSString *)email andPassword:(NSString *)password {
	CheckReachabilityOperation *checkReachability = [self makeCheckReachabilityOperation];
	RegisterAccountOperation *registerAccount = [[RegisterAccountOperation alloc] initWithUsername:username andEmail:email andPassword:password];
	[registerAccount addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[registerAccount addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	[registerAccount addDependency:checkReachability];
	[queue addOperation:checkReachability];
	[queue addOperation:registerAccount];
	[registerAccount autorelease];
}


-(void)fetchFriends {
	FetchFriendsOperation *fetchFriends = [self makeFetchFriendsOperation];
	[queue addOperation:fetchFriends];
}


-(void)addFriend:(NSString *)friendUsername {	
	AddFriendOperation *addFriend = [[AddFriendOperation alloc] initWithFriendUsername:friendUsername];
	[addFriend addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:addFriend];
	[queue addOperation:fetch];
	[queue addOperation:addFriend];
	[addFriend autorelease];
}


-(void)removeFriend:(NSString *)friendUsername {
	RemoveFriendOperation *removeFriend = [[RemoveFriendOperation alloc] initWithFriendUsername:friendUsername];
	[removeFriend addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:removeFriend];
	[removeFriend autorelease];
}



-(void)sendInviteWithMessage:(NSString *)theMessage toEmail:(NSString *)theEmail {
	SendInviteOperation *sendInvite = [[SendInviteOperation alloc] initWithEmail:theEmail andMessage:theMessage];
	[sendInvite addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[sendInvite addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:sendInvite];
	[queue addOperation:fetch];
	[queue addOperation:sendInvite];
	[sendInvite autorelease];
}


-(void)likeRoom:(NSString *)theFriendUsername {		
	LikeRoomOperation *likeRoom = [[LikeRoomOperation alloc] initWithFriendUsername:theFriendUsername];
	[likeRoom addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:likeRoom];
	[queue addOperation:fetch];
	[queue addOperation:likeRoom];
	[likeRoom autorelease];
}


-(void)fetchRecentWallItems:(NSString *)friendUsername forPage:(NSInteger)page{
	FetchRecentWallItemsOperation *fetchRecentWallItems = [[FetchRecentWallItemsOperation alloc] initWithFriendUsername:friendUsername andPage:page];
	[fetchRecentWallItems addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:fetchRecentWallItems];
	[queue addOperation:fetch];
	[queue addOperation:fetchRecentWallItems];
	[fetchRecentWallItems autorelease];
}


-(id)makeFetchForumsOperation {
	FetchForumsOperation *fetchForum = [[FetchForumsOperation alloc] init];
	[fetchForum addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	return [fetchForum autorelease];
}


-(void)fetchTopics:(NSString *)forumId forPage:(NSInteger)page {
	FetchTopicsOperation *fetchTopics = [[FetchTopicsOperation alloc] initWithForumId:forumId andPage:page];
	[fetchTopics addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchTopics];
	[fetchTopics autorelease];
}


-(void)saveTopicInForum:(NSString *)forumId withTitle:(NSString *)title {
	SaveTopicOperation *saveTopic = [[SaveTopicOperation alloc] initWithForumId:forumId andTitle:title];
	[saveTopic addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:saveTopic];
	[saveTopic autorelease];
}


-(void)fetchPosts:(NSString *)topicId forPage:(NSInteger)page {
	FetchPostsOperation *fetchPosts = [[FetchPostsOperation alloc] initWithTopicId:topicId andPage:page];
	[fetchPosts addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchPosts];
	[fetchPosts autorelease];
}


-(void)savePostInTopic:(NSString *)topicId withBody:(NSString *)body {
	SavePostOperation *savePost = [[SavePostOperation alloc] initWithTopicId:topicId andBody:body];
	[savePost addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[savePost addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:savePost];
	[queue addOperation:fetch];
	[queue addOperation:savePost];
	[savePost autorelease];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"isExecuting"]) {
		if ([object isExecuting]) {
			[executingDelegate performSelectorOnMainThread:@selector(didBeginExecuting:) withObject:object waitUntilDone:NO];
		} else {
			[executingDelegate performSelectorOnMainThread:@selector(didEndExecuting) withObject:nil waitUntilDone:NO];
			[object removeObserver:self forKeyPath:@"isExecuting"];
		}
	} else if ([keyPath isEqualToString:@"operations"]) {
	} else if ([keyPath isEqualToString:@"progress"]) {
		[executingDelegate setProgress:[(Operation *)object progress] andMessage:[(Operation *)object operationDescription]];
	} else {
		if ([object isKindOfClass:[CheckReachabilityOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
				} else {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:@"Oops! Your internet left the building... please check back when you find it." andTerminate:YES];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[RegisterAccountOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didRegister];
					[self makeAuthenticateOperation];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[executingDelegate didNotRegister];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[AuthenticateOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didFetchRoom:(NSMutableArray *)[object items]];
					[executingDelegate didFetchScore:[object score]];
					[executingDelegate performSelectorOnMainThread:@selector(didFetchAvatar:) withObject:[object avatar] waitUntilDone:NO];
					[executingDelegate didFetchRoster:(NSMutableDictionary *)[object friends]];
					[executingDelegate performSelectorOnMainThread:@selector(didAuthenticate) withObject:nil waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[executingDelegate performSelectorOnMainThread:@selector(didNotAuthenticate) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[AddFriendOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[self fetchFriends];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchFriendsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didFetchRoster:(NSMutableDictionary *)[object friends]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchScoreOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate performSelectorOnMainThread:@selector(didFetchScore:) withObject:[object score] waitUntilDone:YES];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[RemoveFriendOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[UpdateStatusOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate performSelectorOnMainThread:@selector(didUpdateStatus:) withObject:(NSString *)[object status] waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SaveAvatarOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SendInviteOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didReceiveError:[NSString stringWithFormat:@"Invite Sent to %@", [object email]] andTerminate:NO];
					[invitingDelegate didSendInvite];
				}  else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[invitingDelegate didNotSendInvite];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SaveRoomOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate performSelectorOnMainThread:@selector(didEndPublishing) withObject:nil waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate performSelectorOnMainThread:@selector(didEndPublishing) withObject:nil waitUntilDone:NO];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
			}
			[object removeObserver:self forKeyPath:@"isFinished"];
		} else if ([object isKindOfClass:[SaveToPhotoAlbumOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				[executingDelegate didEndPublishing];
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[LikeRoomOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchFriendsRoomOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[self performSelectorOnMainThread:@selector(didFetchRoom:) withObject:object waitUntilDone:YES];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[avatarViewingDelegate didNotFetchRoom];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchRandomFriendsRoomOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[self performSelectorOnMainThread:@selector(didFetchRoom:) withObject:object waitUntilDone:YES];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[avatarViewingDelegate didNotFetchRoom];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		}  else if ([object isKindOfClass:[FetchMyRoomOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didFetchRoom:(NSMutableArray *)[object items]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchRecentWallItemsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[wallDelegate didFetchRecentWallItems:[object pager]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[wallDelegate performSelectorOnMainThread:@selector(didNotFetchRecentWallItems) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];

			}
		} else if ([object isKindOfClass:[FetchForumsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[executingDelegate didFetchForums:[object forums] andChatrooms:[object chatrooms]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchTopicsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[topicsDelegate performSelectorOnMainThread:@selector(didFetchTopics:) withObject:(PaginatedTopics *)[object pager] waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[topicsDelegate performSelectorOnMainThread:@selector(didNotFetchTopics) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SaveTopicOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[topicsDelegate didSaveTopic];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[topicsDelegate didNotSaveTopic];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchPostsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[postsDelegate didFetchPosts:(PaginatedPosts *)[object pager]];
				} else {
					[queue cancelAllOperations];
					[postsDelegate didNotFetchPosts];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SavePostOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[postsDelegate performSelectorOnMainThread:@selector(didSavePost) withObject:nil waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[postsDelegate performSelectorOnMainThread:@selector(didNotSavePost) withObject:nil waitUntilDone:NO];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		
		} else if ([object isKindOfClass:[DoCharacterAnimationOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[SaveWallMessage class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[wallDelegate performSelectorOnMainThread:@selector(didSaveWallMessage) withObject:nil waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[wallDelegate performSelectorOnMainThread:@selector(didNotSaveWallMessage) withObject:nil waitUntilDone:NO];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchRecentLikesOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[likesDelegate didFetchRecentLikes:(PaginatedLikes *)[object pager]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[likesDelegate didNotFetchRecentLikes];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchRecentVisitsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[visitsDelegate didFetchRecentVisits:(PaginatedVisits *)[object pager]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[visitsDelegate didNotFetchRecentVisits];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[GetStoreItemsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[storeItemsDelegate performSelectorOnMainThread:@selector(didFetchItems:) withObject:[object items] waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[storeItemsDelegate performSelectorOnMainThread:@selector(didNotFetchItems) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchCategoriesOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[storeDelegate performSelectorOnMainThread:@selector(didFetchCategories:) withObject:[object categories] waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[storeDelegate performSelectorOnMainThread:@selector(didNotFetchCategories) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[PurchaseItemOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[storeItemsDelegate didPurchaseItem:[(PurchaseItemOperation *)object item]];
					[executingDelegate didReceiveError:@"New item purchased" andTerminate:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[storeItemsDelegate didNotPurchaseItem];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchPurchasedItemsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[roomEditingDelegate didFetchPurchasedItems:(NSMutableArray *)[object items]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
					[roomEditingDelegate performSelectorOnMainThread:@selector(didNotFetchPurchasedItems) withObject:nil waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchExternalAppsOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[externalAppsDelegate didFetchExternalApps:[object myExternalApps]];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[externalAppsDelegate didNotFetchExternalApps];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[InteractWithFriendOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					[queue cancelAllOperations];
					[executingDelegate didReceiveError:[object errorMessage] andTerminate:![object recoverable]];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		} else if ([object isKindOfClass:[FetchImagesOperation class]]) {
			if ([keyPath isEqualToString:@"isFinished"]) {
				if ([object success]) {
					[itemDownloaderDelegate performSelectorOnMainThread:@selector(didFetchMissingItemImagesFor:) withObject:[object myItemName] waitUntilDone:NO];
				} else if (![object isCancelled] && [object allDependenciesSuccessful]) {
					//[queue cancelAllOperations];
					[itemDownloaderDelegate performSelectorOnMainThread:@selector(didNotFetchMissingItemImagesFor:) withObject:[object myItemName] waitUntilDone:NO];
				}
				[object removeObserver:self forKeyPath:@"isFinished"];
			}
		}
	}	
}


-(void)saveAvatar:(Avatar *)newAvatar {
	SaveAvatarOperation *saveAvatar = [[SaveAvatarOperation alloc] initWithAvatar:newAvatar];	
	[saveAvatar addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:saveAvatar];
	[queue addOperation:fetch];
	[queue addOperation:saveAvatar];
	[saveAvatar autorelease];
}


-(void)saveRoom:(NSMutableArray *)theItems andLayer:(CALayer *)theLayer {
	SaveRoomOperation *saveRoom = [[SaveRoomOperation alloc] initWithItems:theItems andLayer:theLayer];
	[saveRoom addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[saveRoom addObserver:self forKeyPath:@"isExecuting" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:saveRoom];
	[queue addOperation:fetch];
	[queue addOperation:saveRoom];
	[saveRoom autorelease];
}


-(void)doCharacterAnimationOperation {
	DoCharacterAnimationOperation *operation = [[[DoCharacterAnimationOperation alloc] init] autorelease];
	[operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:operation];
	[queue addOperation:fetch];
	[queue addOperation:operation];
}


-(void)interactWithFriend:(NSString *)friendUsername andInteraction:(NSString *)interaction {
	InteractWithFriendOperation *operation = [[InteractWithFriendOperation alloc] initWithFriendUsername:friendUsername andInteraction:interaction];
	[operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:operation];
	[queue addOperation:fetch];
	[queue addOperation:operation];
	[operation autorelease];
}


-(void)saveMessage:(NSString *)theMessage forWall:(NSString *)theFriendUsername {
	SaveWallMessage *operation = [[SaveWallMessage alloc] initWithMessage:theMessage andFriendUsername:theFriendUsername];
	[operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:operation];
	[queue addOperation:fetch];
	[queue addOperation:operation];
	[operation autorelease];
}


-(void)fetchMyRecentLikes:(NSInteger)page {
	FetchRecentLikesOperation *fetchRecentLikes = [[FetchRecentLikesOperation alloc] initWithPage:page];
	[fetchRecentLikes addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchRecentLikes];
	[fetchRecentLikes autorelease];
}


-(void)fetchMyRecentVisits:(NSInteger)page {
	FetchRecentVisitsOperation *fetchRecentVisits = [[FetchRecentVisitsOperation alloc] initWithPage:page];
	[fetchRecentVisits addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchRecentVisits];
	[fetchRecentVisits autorelease];
}

-(void)fetchRecentLikes:(NSString *)friendUsername forPage:(NSInteger)page {
	FetchRecentLikesOperation *fetchRecentLikes = [[FetchRecentLikesOperation alloc] initWithUsername:friendUsername andPage:page];
	[fetchRecentLikes addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchRecentLikes];
	[fetchRecentLikes autorelease];
}

-(void)fetchRecentVisits:(NSString *)friendUsername forPage:(NSInteger)page {
	FetchRecentVisitsOperation *fetchRecentVisits = [[FetchRecentVisitsOperation alloc] initWithUsername:friendUsername andPage:page];
	[fetchRecentVisits addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchRecentVisits];
	[fetchRecentVisits autorelease];
}


-(void)fetchStoreCategories {
	FetchCategoriesOperation *fetchCategories = [[FetchCategoriesOperation alloc] init];
	[fetchCategories addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchCategories];
	[fetchCategories autorelease];
}	


-(void)fetchItemsForCategory:(NSString *)categoryId {
	GetStoreItemsOperation *operation = [[GetStoreItemsOperation alloc] initWithCategoryId:categoryId];
	[operation addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:operation];
	[operation autorelease];
}


-(void)purchaseItem:(FunItem *)theItem {
	PurchaseItemOperation *purchaseItem = [[PurchaseItemOperation alloc] initWithItem:theItem];
	[purchaseItem addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	FetchScoreOperation *fetch = [self makeFetchScoreOpertion];
	[fetch addDependency:purchaseItem];
	[queue addOperation:fetch];
	[queue addOperation:purchaseItem];
	[purchaseItem autorelease];	
}


-(void)fetchPurchasedItemsForCategory:(NSString *)theCategoryDescription {
	FetchPurchasedItemsOperation *fetchPurchasedItems = [[FetchPurchasedItemsOperation alloc] initWithCategoryDescription:theCategoryDescription];
	[fetchPurchasedItems addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchPurchasedItems];
	[fetchPurchasedItems autorelease];
}


-(void)fetchExternalApps {
	FetchExternalAppsOperation *fetchExternalApps = [[FetchExternalAppsOperation alloc] init];
	[fetchExternalApps addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchExternalApps];
	[fetchExternalApps autorelease];
}


-(void)fetchMissingImages:(NSMutableArray *)theMissingFilenames forItemName:(NSString *)theItemName {	
	FetchImagesOperation *fetchImages = [[FetchImagesOperation alloc] initWithItemName:theItemName andMissingFilenames:theMissingFilenames];
	[fetchImages addObserver:self forKeyPath:@"isFinished" options:NSKeyValueObservingOptionNew context:nil];
	[queue addOperation:fetchImages];
	[fetchImages autorelease];
	int countOfFetchMissingImagesOperations = 0;
	for (Operation *operation in [queue operations]) {
		if ([operation isKindOfClass:[FetchImagesOperation class]]) {
      if (operation != fetchImages) {
        [operation addDependency:fetchImages];
      }
		}
	}
}


-(void)didFetchRoom:(FetchFriendsRoomOperation *)theOperation {
	[avatarViewingDelegate didFetchRoom:(NSMutableArray *)[theOperation items] andScore:(Score *)[theOperation score] andAvatar:(Avatar *)[theOperation avatar]];
}


-(void)dealloc {
	[itemDownloaderDelegate release];
	[externalAppsDelegate release];
	[roomEditingDelegate release];
	[avatarViewingDelegate release];
	[invitingDelegate release];
	[visitsDelegate release];
	[storeItemsDelegate release];
	[postsDelegate release];
	[topicsDelegate release];
	[wallDelegate release];
	[storeDelegate release];
	[likesDelegate release];
	[executingDelegate release];
	[fbSession release];
	[queue release];
	[super dealloc];
}


@end