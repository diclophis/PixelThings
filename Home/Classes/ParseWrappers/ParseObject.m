// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"


@implementation ParseObject


@synthesize sourceObject;


-(id)initWithPFObject:(PFObject *)theSourceObject {
  if ((self = [super init])) {
    [self setSourceObject:theSourceObject];
  }

  return self;
}


-(void)dealloc {
  NSLog(@"dealloc ParseObject");
  [sourceObject release];
  [super dealloc];
}


@end
