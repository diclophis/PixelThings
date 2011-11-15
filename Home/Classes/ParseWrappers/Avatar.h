// GPL


@interface Avatar : ParseObject {
}


- (id) initWithStatus: (NSString *) status hair: (NSString *) hair shirt: (NSString *) shirt pants: (NSString *) pants eyebrows: (NSString *) eyebrows eyes: (NSString *) eyes mouth: (NSString *) mouth body: (NSString *) body;
- (NSString *) status;
- (NSString *) hair;
- (NSString *) shirt;
- (NSString *) pants;
- (NSString *) eyebrows;
- (NSString *) eyes;
- (NSString *) mouth;
- (NSString *) body;


@end
