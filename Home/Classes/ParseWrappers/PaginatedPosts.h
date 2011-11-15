// GPL


@interface PaginatedPosts : NSObject {
}


- (int32_t) currentPage;
- (int32_t) perPage;
- (int32_t) totalEntries;
- (int32_t) totalPages;
- (NSArray *) posts;


@end
