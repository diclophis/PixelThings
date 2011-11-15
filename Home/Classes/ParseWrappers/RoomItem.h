// GPL


@interface RoomItem : ParseObject {
}


- (id) initWithX: (int32_t) x y: (int32_t) y z: (int32_t) z itemId: (int32_t) itemId currentVariation: (int32_t) currentVariation;
- (int32_t) x;
- (int32_t) y;
- (int32_t) z;
- (int32_t) itemId;
- (int32_t) currentVariation;


@end
