// GPL

@interface Post : ParseObject {
}

- (NSString *) uid;

- (NSString *) topicId;

- (NSString *) forumId;

- (NSString *) username;

- (NSString *) body;

- (NSString *) createdAt;

@end
