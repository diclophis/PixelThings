// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "RoomItem.h"


@implementation RoomItem


- (id) initWithX: (int32_t) x y: (int32_t) y z: (int32_t) z itemId: (NSString *) itemId currentVariation: (int32_t) currentVariation {
  if ((self = [super init])) {
    sourceObject = [[PFObject alloc] initWithClassName:@"RoomItem"];
    [sourceObject setObject:[NSNumber numberWithInt:x] forKey:@"x"];
    [sourceObject setObject:[NSNumber numberWithInt:y] forKey:@"y"];
    [sourceObject setObject:[NSNumber numberWithInt:z] forKey:@"z"];
    [sourceObject setObject:itemId forKey:@"itemId"];
    [sourceObject setObject:[NSNumber numberWithInt:currentVariation] forKey:@"currentVariation"];
  }

  return self;
}


- (int32_t) x {
  return [[sourceObject objectForKey:@"x"] intValue];
}


- (int32_t) y {
  return [[sourceObject objectForKey:@"y"] intValue];
}


- (int32_t) z {
  return [[sourceObject objectForKey:@"z"] intValue];
}


- (NSString *) itemId {
  return [sourceObject objectForKey:@"itemId"];
}


- (int32_t) currentVariation {
  return [[sourceObject objectForKey:@"currentVariation"] intValue];
}


@end
