// GPL

@interface Post : ParseObject {
}

- (int32_t) id;

- (int32_t) topicId;

- (int32_t) forumId;

- (NSString *) username;

- (NSString *) body;

- (NSString *) createdAt;

@end
