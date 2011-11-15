// GPL


@interface Forum : ParseObject {
}


- (int32_t) id;
- (NSString *) name;
- (NSString *) forumDescription;
- (int32_t) topicsCount;
- (int32_t) postsCount;


@end
