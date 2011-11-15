// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "RoomItem.h"


@implementation RoomItem


- (id) initWithX: (int32_t) x y: (int32_t) y z: (int32_t) z itemId: (int32_t) itemId currentVariation: (int32_t) currentVariation {
  if ((self = [super init])) {
    sourceObject = [[PFObject alloc] initWithClassName:@"RoomItem"];
    [sourceObject setObject:[NSNumber numberWithInt:x] forKey:@"x"];
    [sourceObject setObject:[NSNumber numberWithInt:y] forKey:@"y"];
    [sourceObject setObject:[NSNumber numberWithInt:z] forKey:@"z"];
    [sourceObject setObject:[NSNumber numberWithInt:itemId] forKey:@"itemId"];
    [sourceObject setObject:[NSNumber numberWithInt:currentVariation] forKey:@"currentVariation"];
  }

  return self;
}


- (int32_t) x {
  [[sourceObject objectForKey:@"x"] intValue];
}


- (int32_t) y {
  [[sourceObject objectForKey:@"y"] intValue];
}


- (int32_t) z {
  [[sourceObject objectForKey:@"z"] intValue];
}


- (int32_t) itemId {
  [[sourceObject objectForKey:@"itemId"] intValue];
}


- (int32_t) currentVariation {
  [[sourceObject objectForKey:@"currentVariation"] intValue];
}


@end
