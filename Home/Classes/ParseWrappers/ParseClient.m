// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"


@implementation ParseClient


-(void)dealloc {
  NSLog(@"ParseClient::dealloc");
  [super dealloc];
}


- (BOOL) authenticateWithVersion: (NSString *) username : (NSString *) password : (NSString *) deviceToken : (NSString *) deviceIdentifier : (NSString *) version {
  NSError *error;
  PFUser *user = [PFUser logInWithUsername:username password:password error:&error];
  if (user) {
    return YES;
  } else {
    @throw error;
  }
}


- (BOOL) registerAccount: (NSString *) username : (NSString *) email : (NSString *) password {
  NSError *error;
  PFUser *user = [[PFUser alloc] init];
  user.username = username;
  user.password = password;
  user.email = email;
  if ([user signUp:&error]) {
    PFObject *score = [[PFObject alloc] initWithClassName:@"Score"];
    [score setObject:user forKey:@"user"];
    if ([score save:&error]) {
      PFObject *avatar = [[PFObject alloc] initWithClassName:@"Avatar"];
      [avatar setObject:user forKey:@"user"];
      [avatar setObject:@"wang chung tonite" forKey:@"status"];
      [avatar setObject:@"alpha" forKey:@"eyebrows"];
      [avatar setObject:@"alpha" forKey:@"eyes"];
      [avatar setObject:@"alpha" forKey:@"hair"];
      [avatar setObject:@"alpha" forKey:@"shirt"];
      [avatar setObject:@"alpha" forKey:@"pants"];
      [avatar setObject:@"alpha" forKey:@"mouth"];
      [avatar setObject:@"alpha" forKey:@"body"];
      if ([avatar save:&error]) {
        [user release];
        [score release];
        [avatar release];
        return YES;
      } else {
        [user release];
        [score release];
        [avatar release];
        @throw error;
      }
    } else {
      [user release];
      [score release];
      @throw error;
    }
  } else {
    [user release];
    @throw error;
  }
}


- (NSArray *) fetchFriends: (NSString *) username {
  @throw [NSException exceptionWithName:@"fetchFriends not implemented" reason:nil userInfo:nil];
}


- (BOOL) addFriend: (NSString *) username : (NSString *) friendUsername {
  return NO;
}


- (BOOL) removeFriend: (NSString *) username : (NSString *) friendUsername {
}


- (BOOL) updateStatus: (NSString *) username : (NSString *) status {
}


- (Friend *) randomFriend: (NSString *) username {
  @throw [NSException exceptionWithName:@"randomFriend not implemented" reason:nil userInfo:nil];
}


- (BOOL) saveRoom: (NSString *) username : (NSArray *) roomItems {
  NSError *error;
  PFQuery *userQuery = [PFQuery queryForUser];
  [userQuery whereKey:@"username" equalTo:username];
  NSArray *users = [userQuery findObjects:&error];
  if (users && [users count]) {
    PFObject *user = [users objectAtIndex:0];
    NSMutableArray *pfRoomItems = [NSMutableArray arrayWithCapacity:0];
    for (RoomItem *roomItem in roomItems) {
      PFObject *pfRoomItem = [roomItem sourceObject];
      [pfRoomItem setObject:user forKey:@"user"];
      [pfRoomItems addObject:pfRoomItem];
    }
    if ([PFObject saveAll:pfRoomItems error:&error]) {
      return YES;
    } else {
      @throw error;
    }
  } else {
    @throw error;
  }
}


- (NSArray *) fetchRoom: (NSString *) username {
  @throw [NSException exceptionWithName:@"fetchRoom not implemented" reason:nil userInfo:nil];
}


- (Score *) fetchScore: (NSString *) friendUsername {
  NSError *error;
  PFQuery *userQuery = [PFQuery queryForUser];
  [userQuery whereKey:@"username" equalTo:friendUsername];
  NSArray *users = [userQuery findObjects:&error];
  if (users && [users count]) {
    PFObject *user = [users objectAtIndex:0];
    PFQuery *scoreQuery = [PFQuery queryWithClassName:@"Score"];
    [scoreQuery whereKey:@"user" equalTo:user];
    NSArray *usersScores = [scoreQuery findObjects:&error];
    if (usersScores && [usersScores count]) {
      return [[[Score alloc] initWithPFObject:[usersScores objectAtIndex:0]] autorelease];
    } else {
      @throw error;
    }
  } else {
    @throw error;
  }
}


- (BOOL) sendInvite: (NSString *) username : (NSString *) email : (NSString *) message {
}


- (BOOL) saveCharacter: (NSString *) username : (Character *) bodyParts {
}


- (BOOL) saveAvatar: (NSString *) username : (Avatar *) avatar {
  NSError *error;
  PFQuery *userQuery = [PFQuery queryForUser];
  [userQuery whereKey:@"username" equalTo:username];
  NSArray *users = [userQuery findObjects:&error];
  if (users && [users count]) {
    [[avatar sourceObject] setObject:[users objectAtIndex:0] forKey:@"user"];
    if ([[avatar sourceObject] save:&error]) {
      return YES;
    } else {
      @throw error;
    }
  } else {
    @throw error;
  }
}


- (Character *) fetchCharacter: (NSString *) username {
  return nil;
}


- (Avatar *) fetchAvatar: (NSString *) username {
  NSError *error;
  PFQuery *userQuery = [PFQuery queryForUser];
  [userQuery whereKey:@"username" equalTo:username];
  NSArray *users = [userQuery findObjects:&error];
  if (users && [users count]) {
    PFObject *user = [users objectAtIndex:0];
    PFQuery *avatarQuery = [PFQuery queryWithClassName:@"Avatar"];
    [avatarQuery whereKey:@"user" equalTo:user];
    NSArray *usersAvatars = [avatarQuery findObjects:&error];
    if (usersAvatars && [usersAvatars count]) {
      return [[[Avatar alloc] initWithPFObject:[usersAvatars objectAtIndex:0]] autorelease];
    } else {
      @throw error;
    }
  } else {
    @throw error;
  }
}


- (BOOL) saveProfile: (NSString *) username : (NSString *) deviceId : (NSString *) facebookUserId {
}


- (BOOL) likeRoom: (NSString *) username : (NSString *) friendUsername {
}


- (BOOL) visitRoom: (NSString *) username : (NSString *) friendUsername {
}


- (PaginatedLikes *) fetchRecentLikes: (NSString *) username : (int32_t) page {
  @throw [NSException exceptionWithName:@"fetchRecentLikes not implemented" reason:nil userInfo:nil];
}


- (PaginatedVisits *) fetchRecentVisits: (NSString *) username : (int32_t) page {
  @throw [NSException exceptionWithName:@"fetchRecentVisits not implemented" reason:nil userInfo:nil];
}


- (PaginatedWallItems *) fetchRecentWallItems: (NSString *) username : (int32_t) page : (BOOL) mine {
  @throw [NSException exceptionWithName:@"fetchRecentWallItems not implemented" reason:nil userInfo:nil];
}


- (NSArray *) fetchForums {
  @throw [NSException exceptionWithName:@"fetchForums not implemented" reason:nil userInfo:nil];
}


- (NSArray *) fetchChatrooms {
  @throw [NSException exceptionWithName:@"fetchChatrooms not implemented" reason:nil userInfo:nil];
}


- (PaginatedTopics *) fetchTopics: (int32_t) forumId : (int32_t) page {
  @throw [NSException exceptionWithName:@"fetchTopics not implemented" reason:nil userInfo:nil];
}


- (BOOL) saveTopic: (NSString *) username : (int32_t) forumId : (NSString *) title {
}


- (PaginatedPosts *) fetchPosts: (int32_t) topicId : (int32_t) page {
  @throw [NSException exceptionWithName:@"fetchRoom not implemented" reason:nil userInfo:nil];
}


- (BOOL) savePost: (NSString *) username : (int32_t) topicId : (NSString *) body {
}


- (int32_t) getPoints: (NSString *) username {
}


- (NSString *) getImageUrl: (NSString *) name {
}


- (BOOL) doCharacterAnimation: (NSString *) username {
  return NO;
}


- (BOOL) saveWallMessage: (NSString *) username : (NSString *) friendUsername : (NSString *) message {
}


- (BOOL) saveScreenshot: (NSString *) username : (NSArray *) bytes {
}


- (NSArray *) getStoreItems: (int32_t) categoryId {
  NSError *error;
  PFQuery *funItemQuery = [PFQuery queryWithClassName:@"FunItem"];
  [funItemQuery whereKey:@"itemCategoryId" equalTo:[NSNumber numberWithInt:categoryId]];
  NSArray *funItems = [funItemQuery findObjects:&error];
  if (funItems) {
    NSLog(@"found items");
    NSMutableArray *tmpItems = [NSMutableArray arrayWithCapacity:0];
    for (PFObject *pfFunItem in funItems) {
      FunItem *funItem = [[FunItem alloc] initWithPFObject:pfFunItem];
      [tmpItems addObject:funItem];
      [funItem release];
    }
    return tmpItems;
  } else {
    @throw error;
  }
}


- (NSArray *) getItemCategories {
  NSError *error;
  PFQuery *query = [PFQuery queryWithClassName:@"ItemCategory"];
  NSArray *pfCategories = [query findObjects:&error];
  if (pfCategories)  {
    NSMutableArray *tmpCategories = [NSMutableArray arrayWithCapacity:0];
    for (PFObject *pfCategory in pfCategories) {
      ItemCategory *itemCategory = [[ItemCategory alloc] initWithPFObject:pfCategory];
      [tmpCategories addObject:itemCategory];
      [itemCategory release];
    }
    return tmpCategories;
  } else {
    @throw error;
  }
}


- (BOOL) purchaseItem: (NSString *) username : (int32_t) itemId : (int32_t) quantity {
}


- (NSArray *) getInventoryItems: (NSString *) username {
}


- (NSArray *) fetchPurchasedItems: (NSString *) username : (NSString *) categoryDescription {
  @throw [NSException exceptionWithName:@"fetchRoom not implemented" reason:nil userInfo:nil];
}


- (NSArray *) getSkeletonPieceList: (NSString *) skeletonName : (NSString *) pieceName {
}


- (BOOL) saveAvatarScreenshot: (NSString *) username : (NSArray *) bytes {
}


- (BOOL) saveAvatarMessage: (NSString *) username : (NSString *) email : (NSString *) message {
}


- (BOOL) loginToFunjiStore: (NSString *) username {
}


- (NSArray *) getInventoryAvatarItems: (NSString *) skeletonName : (NSString *) pieceName {
}


- (NSArray *) fetchExternalApps: (NSString *) username {
  return nil;
}


- (BOOL) interactWithFriend: (NSString *) username : (NSString *) friendUsername : (NSString *) interaction {
}


@end
