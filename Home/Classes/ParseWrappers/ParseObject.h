// GPL


@interface ParseObject : NSObject {
  PFObject *sourceObject;
}


@property (nonatomic, retain) PFObject *sourceObject;


-(id)initWithPFObject:(PFObject *)theSourceObject;


@end
