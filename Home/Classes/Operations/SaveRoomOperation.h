// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveRoomOperation : Operation {
	NSMutableArray *items;
	CALayer *layer;
	UIImage *image;
	NSData *data;
	NSMutableArray *array;
}

@property (retain) CALayer *layer;
@property (retain) NSMutableArray *items;
@property (retain) UIImage *image;
@property (retain) NSData *data;
@property (retain) NSMutableArray *array;

-(id)initWithItems:(NSMutableArray *)theItems andLayer:(CALayer *)theLayer;


@end
