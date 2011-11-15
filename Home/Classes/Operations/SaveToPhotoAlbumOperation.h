// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface SaveToPhotoAlbumOperation : Operation {
	CALayer *layer;
	UIImage *image;
}


@property (nonatomic, retain) CALayer *layer;
@property (nonatomic, retain) UIImage *image;

-(id)initWithLayer:(CALayer *)theLayer;


@end
