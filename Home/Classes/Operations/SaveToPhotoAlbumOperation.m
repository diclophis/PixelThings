// GPL

#import "SaveToPhotoAlbumOperation.h"
#import <QuartzCore/QuartzCore.h>


@implementation SaveToPhotoAlbumOperation


@synthesize layer;
@synthesize image;

-(id)initWithLayer:(CALayer *)theImage {
	if (self = [super init]) {
		[self setOperationDescription:@"Saving to your photo album"];
		[self setLayer:theImage];
	}
	return self;
}


-(void)main {	
	CGSize size = CGSizeMake(480.0f, 320.0f);
	UIGraphicsBeginImageContext(size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextRetain(context);
	if (context != nil) {
		[layer renderInContext:context];
		image = UIGraphicsGetImageFromCurrentImageContext();
		UIImageWriteToSavedPhotosAlbum(image, self, nil, context);
	}
	CGContextRelease(context);	 
}


-(void)dealloc {
	[layer release];
	[super dealloc];
}


@end
