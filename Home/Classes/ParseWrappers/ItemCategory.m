// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ItemCategory.h"


@implementation ItemCategory


- (NSString *) uid {
  return [sourceObject objectId];
}


- (NSString *) categoryDescription {
  return [sourceObject objectForKey:@"description"];
}


@end
