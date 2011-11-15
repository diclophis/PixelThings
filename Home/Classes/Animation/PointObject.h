// GPL

#import <Foundation/Foundation.h>


@interface PointObject : NSObject {
	CGPoint point;
}

@property (nonatomic) CGPoint point;

-(PointObject *)initWithPoint:(CGPoint)thePoint;

+(PointObject *)pointObjectWithX:(CGFloat)x andY:(CGFloat)y;

@end
