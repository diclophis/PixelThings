// GPL


#import <QuartzCore/QuartzCore.h>
#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Item.h"
#import "SaveRoomOperation.h"


@implementation SaveRoomOperation


@synthesize items;
@synthesize layer;
@synthesize data;
@synthesize image;
@synthesize array;


-(id)initWithItems:(NSMutableArray *)theItems andLayer:(CALayer *)theLayer {
	if ((self = [super init])) {
		[self setIndicatesProgress:YES];
		[self setOperationDescription:@"Saving Room..."];
		[self setLayer:theLayer];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
		NSInteger z=0;
		for (Item *item in theItems) {
			if ([item isKindOfClass:[Item class]]) {
				RoomItem *theTranslatedItem = [[RoomItem alloc] initWithX:[item center].x y:[item center].y z:z itemId:[item itemId] currentVariation:[item currentVariation]];
				[items addObject:theTranslatedItem];
				[theTranslatedItem release];
				z++;
			}
		}
	}
	return self;
}


-(void)dealloc {
	[array release];
	[data release];
	[image release];
	[layer release];
	[items release];
	[super dealloc];
}


-(void)main {	
	@try {
		if ([self connect]) {
			[self setSuccess:[client saveRoom:username :items]];
			if (success) {
				CGSize size = CGSizeMake(480.0f, 320.0f);
				UIGraphicsBeginImageContext(size);
				CGContextRef context = UIGraphicsGetCurrentContext();
				CGContextRetain(context);
				if (context != nil) {
					[layer renderInContext:context];
					[self setImage:UIGraphicsGetImageFromCurrentImageContext()];
					[self setData:UIImageJPEGRepresentation(image, 0.6f)];
					[self setArray:[NSMutableArray arrayWithCapacity:[data length]]];
					NSUInteger len = [data length];
					Byte *byteData = (Byte*)malloc(len);
					memcpy(byteData, [data bytes], len);
					for (NSInteger i = 0; i<len; i++) {
						[array addObject:[NSNumber numberWithUnsignedChar:byteData[i]]];
					}
					//[client saveScreenshot:username :array];
				}
				CGContextRelease(context);
			} else {
				[self setErrorMessage:@"Unable to save room, please try again!"];
			}
		}
	}
	
	@catch (id theException) {
		[self setErrorMessage:@"There was an error saving your room, please try again"];
	}
}


@end
