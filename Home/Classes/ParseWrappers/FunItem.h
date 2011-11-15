// GPL

@interface FunItem : ParseObject {
}

- (int32_t) id;
- (int32_t) itemCategoryId;
- (NSString *) name;
- (NSString *) filename;
- (int32_t) variations;
- (int32_t) frames;
- (int32_t) costInPoints;
- (int32_t) quantityAvailable;
- (BOOL) constrained;


@end
