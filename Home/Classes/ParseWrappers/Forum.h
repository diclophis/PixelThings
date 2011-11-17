// GPL


@interface Forum : ParseObject {
}


- (NSString *) uid;
- (NSString *) name;
- (NSString *) forumDescription;
- (int32_t) topicsCount;
- (int32_t) postsCount;


@end
