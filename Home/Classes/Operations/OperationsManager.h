// GPL

#import <Foundation/Foundation.h>
#import "Reachability.h"


@class DLOperationQueue;
@class FBSession;
@class AnimatedPerson;
@class Operation;
@class FetchFriendsRoomOperation;
@class Avatar;
@class Score;
@class PaginatedWallItems;
@class PaginatedTopics;
@class PaginatedPosts;
@class PaginatedVisits;
@class PaginatedLikes;
@class FunItem;


@protocol ExecutingDelegate
-(void)didBeginExecuting:(Operation *)operation;
-(void)didEndExecuting;
-(void)setProgress:(NSNumber *)progress andMessage:(NSString *)message;
-(void)didAuthenticate;
-(void)didNotAuthenticate;
-(void)didUpdateStatus:(NSString *)theStatus;
-(void)didFetchAvatar:(Avatar *)theAvatar;
-(void)didFetchScore:(Score *)theScore;
-(void)didFetchForums:(NSArray *)theForums andChatrooms:(NSArray *)theChatrooms;
-(void)didFetchRoom:(NSMutableArray *)theItems;
-(void)didRegister;
-(void)didNotRegister;
-(void)didFetchRoster:(NSMutableDictionary *)roster;
-(NSMutableDictionary *)roster;
-(void)didReceiveError:(NSString *)message andTerminate:(BOOL)terminate;
-(void)willBeginPublishing;
-(void)didEndPublishing;
@end


@protocol AvatarViewingDelegate<NSObject>
-(void)didFetchRoom:(NSMutableArray *)theItems andScore:(Score *)theScore andAvatar:(Avatar *)theAvatar;
-(void)didNotFetchRoom;
@end


@protocol ItemDownloaderDelegate<NSObject>
-(void)didFetchMissingItemImagesFor:(NSString *)theItemName;
-(void)didNotFetchMissingItemImagesFor:(NSString *)theItemName;
@end


@protocol InviteDelegate<NSObject>
-(void)didSendInvite;
-(void)didNotSendInvite;
@end


@protocol WallDelegate<NSObject>
-(void)didFetchRecentWallItems:(PaginatedWallItems *)thePager;
-(void)didNotFetchRecentWallItems;
-(void)didSaveWallMessage;
-(void)didNotSaveWallMessage;
@end


@protocol TopicsDelegate<NSObject>
-(void)didFetchTopics:(PaginatedTopics *)thePager;
-(void)didNotFetchTopics;
-(void)didSaveTopic;
-(void)didNotSaveTopic;
@end


@protocol PostsDelegate<NSObject>
-(void)didFetchPosts:(PaginatedPosts *)thePager;
-(void)didNotFetchPosts;
-(void)didSavePost;
-(void)didNotSavePost;
@end


@protocol LikesDelegate<NSObject>
-(void)didFetchRecentLikes:(PaginatedLikes *)thePager;
-(void)didNotFetchRecentLikes;
@end


@protocol VisitsDelegate<NSObject>
-(void)didFetchRecentVisits:(PaginatedVisits *)thePager;
-(void)didNotFetchRecentVisits;
@end


@protocol StoreDelegate<NSObject>
-(void)didFetchCategories:(NSArray *)theCategories;
-(void)didNotFetchCategories;
@end


@protocol StoreItemsDelegate<NSObject>
-(void)didFetchItems:(NSArray *)theItems;
-(void)didNotFetchItems;
-(void)didPurchaseItem:(FunItem *)theItem;
-(void)didNotPurchaseItem;
@end


@protocol ExternalAppsDelegate<NSObject>
-(void)didFetchExternalApps:(NSMutableArray *)theExternalApps;
-(void)didNotFetchExternalApps;
@end


@protocol RoomEditingDelegate<NSObject>
-(void)didFetchPurchasedItems:(NSMutableArray *)theItems;
-(void)didNotFetchPurchasedItems;
@end


@interface OperationsManager : NSObject {
	NSOperationQueue *queue;
	UIViewController<ExecutingDelegate> *executingDelegate;
	NSObject <AvatarViewingDelegate> *avatarViewingDelegate;
	NSObject <InviteDelegate> *invitingDelegate;
	UIViewController<WallDelegate> *wallDelegate;
	NSObject<TopicsDelegate> *topicsDelegate;
	NSObject<PostsDelegate> *postsDelegate;
	NSObject<LikesDelegate> *likesDelegate;
	NSObject<VisitsDelegate> *visitsDelegate;
	NSObject<StoreDelegate> *storeDelegate;
	NSObject<StoreItemsDelegate> *storeItemsDelegate;
	NSObject<RoomEditingDelegate> *roomEditingDelegate;
	NSObject<ExternalAppsDelegate> *externalAppsDelegate;
	NSObject<ItemDownloaderDelegate> *itemDownloaderDelegate;
	
	NetworkStatus remoteHostStatus;
	NetworkStatus internetConnectionStatus;
	NetworkStatus localWiFiConnectionStatus;
}


@property (retain) NSOperationQueue *queue;
@property (retain) id<ExecutingDelegate> executingDelegate;
@property (retain) id<AvatarViewingDelegate> avatarViewingDelegate;
@property (retain) id<InviteDelegate> invitingDelegate;
@property (retain) id<WallDelegate> wallDelegate;
@property (retain) id<TopicsDelegate> topicsDelegate;
@property (retain) id<PostsDelegate> postsDelegate;
@property (retain) id<LikesDelegate> likesDelegate;
@property (retain) id<VisitsDelegate> visitsDelegate;
@property (retain) id<StoreDelegate> storeDelegate;
@property (retain) id<StoreItemsDelegate> storeItemsDelegate;
@property (retain) id<RoomEditingDelegate> roomEditingDelegate;
@property (retain) id<ExternalAppsDelegate> externalAppsDelegate;
@property (retain) id<ItemDownloaderDelegate> itemDownloaderDelegate;


@property (retain) FBSession *fbSession;
@property NetworkStatus remoteHostStatus;
@property NetworkStatus internetConnectionStatus;
@property NetworkStatus localWiFiConnectionStatus;


+(OperationsManager *)sharedInstance;
-(void)checkReachability;
-(id)makeFetchFriendsOperation;
-(id)makeAuthenticateOperation;
-(id)makeUpdateStatusOperation:(NSString *)theStatus;
-(id)makeCheckReachabilityOperation;
-(id)makeCheckReachabilityOperationWithoutDescription;
-(id)makeFetchScoreOpertion;
-(id)makeFetchForumsOperation;
-(id)makeFetchMyRoomOperation;
-(void)authenticate;
-(void)registerUsername:(NSString *)username andEmail:(NSString *)email andPassword:(NSString *)password;
-(void)fetchFriends;
-(void)addFriend:(NSString *)username;
-(void)removeFriend:(NSString *)username;
-(void)updateStatus:(NSString *)theStatus;
-(void)saveAvatar:(Avatar *)newAvatar;
-(void)saveRoom:(NSMutableArray *)theItems andLayer:(CALayer *)theLayer;
-(void)fetchFriendsRoom:(NSString *)theFriendUsername;
-(void)saveToPhotoAlbum:(CALayer *)layer;
-(void)sendInviteWithMessage:(NSString *)theMessage toEmail:(NSString *)theEmail;
-(void)likeRoom:(NSString *)friendUsername;
-(void)fetchRandomFriendsRoom;
-(void)fetchRecentWallItems:(NSString *)theFriendUsername forPage:(NSInteger)page;
-(void)fetchTopics:(NSString *)forumId forPage:(NSInteger)page;
-(void)saveTopicInForum:(NSString *)forumId withTitle:(NSString *)title;
-(void)fetchPosts:(NSString *)topicId forPage:(NSInteger)page;
-(void)savePostInTopic:(NSString *)topicId withBody:(NSString *)body;
-(void)doCharacterAnimationOperation;
-(void)saveMessage:(NSString *)theMessage forWall:(NSString *)theFriendUsername; 
-(void)fetchMyRecentLikes:(NSInteger)page;
-(void)fetchMyRecentVisits:(NSInteger)page;
-(void)fetchRecentLikes:(NSString *)friendUsername forPage:(NSInteger)page;
-(void)fetchRecentVisits:(NSString *)friendUsername forPage:(NSInteger)page;
-(void)fetchStoreCategories;
-(void)fetchItemsForCategory:(NSString *)categoryId;
-(void)purchaseItem:(FunItem *)theItem;
-(void)fetchPurchasedItemsForCategory:(NSString *)theCategoryDescription;
-(void)fetchExternalApps;
-(void)interactWithFriend:(NSString *)friendUsername andInteraction:(NSString *)interaction;
-(void)didFetchRoom:(FetchFriendsRoomOperation *)theOperation;
-(void)fetchMissingImages:(NSMutableArray *)theMissingFilenames forItemName:(NSString *)theItemName;


@end
