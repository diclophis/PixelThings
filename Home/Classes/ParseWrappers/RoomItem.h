// GPL


@interface RoomItem : ParseObject {
}


- (id) initWithX: (int32_t) x y: (int32_t) y z: (int32_t) z itemId: (NSString *) itemId currentVariation: (int32_t) currentVariation;
- (int32_t) x;
- (int32_t) y;
- (int32_t) z;
- (NSString *) itemId;
- (int32_t) currentVariation;


@end
