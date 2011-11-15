// GPL


@interface Topic : ParseObject {
}


- (int32_t) id;
- (int32_t) forumId;
- (NSString *) username;
- (NSString *) title;
- (int32_t) hits;
- (int32_t) posts_count;
- (NSString *) createdAt;
- (NSString *) latestCreatedAt;
- (NSString *) latestUsername;


@end
