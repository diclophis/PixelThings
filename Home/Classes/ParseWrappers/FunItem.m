// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "FunItem.h"


@implementation FunItem


- (NSString *) uid {
  return [sourceObject objectId];
}


- (NSString *) itemCategoryId {
  return [sourceObject objectForKey:@"itemCategoryId"];
}


- (NSString *) name {
  return [sourceObject objectForKey:@"name"];
}


- (NSString *) filename {
  return [sourceObject objectForKey:@"filename"];
}


- (int32_t) variations {
  return [[sourceObject objectForKey:@"variations"] intValue];
}


- (int32_t) frames {
  return [[sourceObject objectForKey:@"frames"] intValue];
}


- (int32_t) costInPoints {
  return [[sourceObject objectForKey:@"costInPoints"] intValue];
}


- (int32_t) quantityAvailable {
  return [[sourceObject objectForKey:@"quantityAvailable"] intValue];
}


- (BOOL) constrained {
  return [[sourceObject objectForKey:@"constrained"] boolValue];
}


@end
