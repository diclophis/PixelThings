// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ItemCategory.h"


@implementation ItemCategory


- (int32_t) id {
  return [[sourceObject objectForKey:@"integer_id"] intValue];
}


- (NSString *) categoryDescription {
  return [sourceObject objectForKey:@"description"];
}


@end
