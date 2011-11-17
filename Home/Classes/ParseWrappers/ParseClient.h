// GPL

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
#import "ViewableRoomItem.h"


@interface ParseClient : NSObject {
}


- (BOOL) authenticateWithVersion: (NSString *) username : (NSString *) password : (NSString *) deviceToken : (NSString *) deviceIdentifier : (NSString *) version;
- (BOOL) registerAccount: (NSString *) username : (NSString *) email : (NSString *) password;
- (NSArray *) fetchFriends: (NSString *) username;
- (BOOL) addFriend: (NSString *) username : (NSString *) friendUsername;
- (BOOL) removeFriend: (NSString *) username : (NSString *) friendUsername;
- (BOOL) updateStatus: (NSString *) username : (NSString *) status; 
- (Friend *) randomFriend: (NSString *) username;
- (BOOL) saveRoom: (NSString *) username : (NSArray *) roomItems;
- (NSArray *) fetchRoom: (NSString *) username;
- (Score *) fetchScore: (NSString *) friendUsername;
- (BOOL) sendInvite: (NSString *) username : (NSString *) email : (NSString *) message;
- (BOOL) saveCharacter: (NSString *) username : (Character *) bodyParts;
- (BOOL) saveAvatar: (NSString *) username : (Avatar *) bodyParts;
- (Character *) fetchCharacter: (NSString *) username;
- (Avatar *) fetchAvatar: (NSString *) username;
- (BOOL) saveProfile: (NSString *) username : (NSString *) deviceId : (NSString *) facebookUserId;
- (BOOL) likeRoom: (NSString *) username : (NSString *) friendUsername;
- (BOOL) visitRoom: (NSString *) username : (NSString *) friendUsername;
- (PaginatedLikes *) fetchRecentLikes: (NSString *) username : (int32_t) page;
- (PaginatedVisits *) fetchRecentVisits: (NSString *) username : (int32_t) page;
- (PaginatedWallItems *) fetchRecentWallItems: (NSString *) username : (int32_t) page : (BOOL) mine;
- (NSArray *) fetchForums;
- (NSArray *) fetchChatrooms;
- (PaginatedTopics *) fetchTopics: (NSString *) forumId : (int32_t) page;
- (BOOL) saveTopic: (NSString *) username : (NSString *) forumId : (NSString *) title;
- (PaginatedPosts *) fetchPosts: (NSString *) topicId : (int32_t) page;
- (BOOL) savePost: (NSString *) username : (NSString *) topicId : (NSString *) body;
- (int32_t) getPoints: (NSString *) username;
- (NSString *) getImageUrl: (NSString *) name;
- (BOOL) doCharacterAnimation: (NSString *) username;
- (BOOL) saveWallMessage: (NSString *) username : (NSString *) friendUsername : (NSString *) message;
- (BOOL) saveScreenshot: (NSString *) username : (NSArray *) bytes;
- (NSArray *) getStoreItems: (NSString *) categoryId;
- (NSArray *) getItemCategories;
- (BOOL) purchaseItem: (NSString *) username : (NSString *) itemId : (int32_t) quantity;
- (NSArray *) getInventoryItems: (NSString *) username;
- (NSArray *) fetchPurchasedItems: (NSString *) username : (NSString *) categoryDescription;
- (NSArray *) getSkeletonPieceList: (NSString *) skeletonName : (NSString *) pieceName;
- (BOOL) saveAvatarScreenshot: (NSString *) username : (NSArray *) bytes;
- (BOOL) saveAvatarMessage: (NSString *) username : (NSString *) email : (NSString *) message;
- (NSArray *) getInventoryAvatarItems: (NSString *) skeletonName : (NSString *) pieceName;
- (NSArray *) fetchExternalApps: (NSString *) username;
- (BOOL) interactWithFriend: (NSString *) username : (NSString *) friendUsername : (NSString *) interaction;


@end
