// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Avatar.h"


@implementation Avatar


- (id) initWithStatus: (NSString *) status hair: (NSString *) hair shirt: (NSString *) shirt pants: (NSString *) pants eyebrows: (NSString *) eyebrows eyes: (NSString *) eyes mouth: (NSString *) mouth body: (NSString *) body {
  if ((self = [super init])) {
    sourceObject = [[PFObject alloc] initWithClassName:@"Avatar"];
    [sourceObject setObject:status forKey:@"status"];
    [sourceObject setObject:eyebrows forKey:@"eyebrows"];
    [sourceObject setObject:eyes forKey:@"eyes"];
    [sourceObject setObject:hair forKey:@"hair"];
    [sourceObject setObject:shirt forKey:@"shirt"];
    [sourceObject setObject:pants forKey:@"pants"];
    [sourceObject setObject:mouth forKey:@"mouth"];
    [sourceObject setObject:body forKey:@"body"];
  }

  return self;
}


- (NSString *) status {
  return [sourceObject objectForKey:@"status"];
}


- (NSString *) hair {
  return [sourceObject objectForKey:@"hair"];
}


- (NSString *) shirt {
  return [sourceObject objectForKey:@"shirt"];
}


- (NSString *) pants {
  return [sourceObject objectForKey:@"pants"];
}


- (NSString *) eyebrows {
  return [sourceObject objectForKey:@"eyebrows"];
}


- (NSString *) eyes {
  return [sourceObject objectForKey:@"eyes"];
}


- (NSString *) mouth {
  return [sourceObject objectForKey:@"mouth"];
}


- (NSString *) body {
  return [sourceObject objectForKey:@"body"];
}


@end
