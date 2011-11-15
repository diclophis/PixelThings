// GPL

#import "Item.h"


static ItemManager *itemManagerInstance = NULL;


@implementation ItemManager


@synthesize myDocumentsDirectory;
@synthesize myVisibleItems;
@synthesize myMissingFilesForItem;
@synthesize myDatas;


-(void)dealloc {
	NSLog(@"ItemManager::dealloc");
	[myDocumentsDirectory release];
	[myVisibleItems release];
	[myMissingFilesForItem release];
	[myDatas release];
	[super dealloc];
}


+(ItemManager *)sharedInstance {
	@synchronized(self) {
		if (itemManagerInstance == NULL) {
            itemManagerInstance = [[self alloc] init];
		}
	}
    return itemManagerInstance;
}


-(id)init {
	if ((self = [super init])) {
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		[self setMyDocumentsDirectory:[paths objectAtIndex:0]];
		[self setMyVisibleItems:[NSMutableDictionary dictionaryWithCapacity:0]];
		[self setMyMissingFilesForItem:[NSMutableDictionary dictionaryWithCapacity:0]];
		[self setMyDatas:[NSMutableDictionary dictionaryWithCapacity:0]];
		[[OperationsManager sharedInstance] setItemDownloaderDelegate:self];
	}
	return self;
}


-(BOOL)registerItem:(Item *)theItem {
	BOOL filesExist = YES;

	NSMutableArray *missingFilenames = [self missingFilenamesForItem:theItem];
	
	NSMutableArray *itemsByName = [myVisibleItems objectForKey:[theItem filename]];
	

	if ([missingFilenames count] > 0) {
		if (!itemsByName) {
			itemsByName = [NSMutableArray arrayWithCapacity:0];
			[myVisibleItems setObject:itemsByName forKey:[theItem filename]];
		}
		if ([itemsByName containsObject:theItem]) {
		} else {
			[itemsByName addObject:theItem];
			[[OperationsManager sharedInstance] fetchMissingImages:missingFilenames forItemName:[theItem filename]];
		}
		filesExist = NO;
	} else {

	}
	
	return filesExist;
}


-(NSMutableArray *)missingFilenamesForItem:(Item *)theItem {
	NSMutableArray *missingFilenames = [NSMutableArray arrayWithCapacity:0];	
	for (NSInteger variation=0; variation<[theItem variations]; variation++) {
		for (NSInteger frame=0; frame<[theItem frames]; frame++) {
			NSString *filename = [NSString stringWithFormat:@"%@_%03d_%03d.png", [theItem filename], (variation), (frame+1)];
			NSString *path = [myDocumentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", filename]];
			BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path];
			BOOL valid = YES;
			if (exists && valid) {
			} else {
				[missingFilenames addObject:filename];
			}
		}
	}
	return missingFilenames;
}


-(void)didFetchMissingItemImagesFor:(NSString *)theItemName {
  for (Item *visibleItem in [myVisibleItems objectForKey:theItemName]) {
    if ([[visibleItem filename] isEqualToString:theItemName]) {
      [visibleItem displayCurrentImage];
    }
  }
  
  [[myVisibleItems objectForKey:theItemName] removeAllObjects];
  [myVisibleItems removeObjectForKey:theItemName];
}


-(void)didNotFetchMissingItemImagesFor:(NSString *)theItemName {	
	for (Item *visibleItem in [myVisibleItems objectForKey:theItemName]) {
		[visibleItem displayImageNotFound];
	}
	[[myVisibleItems objectForKey:theItemName] removeAllObjects];
	[myVisibleItems removeObjectForKey:theItemName];
}


-(UIImage *)imageWithParameters:(NSString *)theFilename andVariation:(NSInteger)theVariation andFrame:(NSInteger)theFrame {
	NSString *filenameToLoad = [NSString stringWithFormat:@"%@_%03d_%03d.png", theFilename, theVariation, theFrame];
	NSString *path = [myDocumentsDirectory stringByAppendingString:[NSString stringWithFormat:@"/%@", filenameToLoad]];	
	UIImage *image;
	NSData *data = [[self myDatas] objectForKey:filenameToLoad];
  BOOL loadedFromFile = NO;
	if ([data length] == 0) {
		data = [[NSData alloc] initWithContentsOfFile:path];
    loadedFromFile = YES;
	}
	if ([data length] > 0) {
		image = [UIImage imageWithData:data];
	} else {
		image = nil;
	}
  if (loadedFromFile) {
    [data release];
  }
	return image;
}


@end


@implementation Item


@synthesize currentVariation;
@synthesize dropped;
@synthesize itemId;
@synthesize filename;
@synthesize variations;
@synthesize frames;
@synthesize constrained;


-(void)dealloc {
	[filename release];
	[super dealloc];
}


-(id)initWithFrame:(CGRect)theFrame {
	if ((self = [super initWithFrame:theFrame])) {
	}
	return self;
}


-(id)initWithItemId:(NSInteger)theItemId andFilename:(NSString *)theFilename andVariations:(NSInteger)theVariations andFrames:(NSInteger)theFrames andConstrained:(BOOL)theConstrained andCurrentVariation:(NSInteger)theCurrentVariation {
	if ((self = [super init])) {
		[self setItemId:theItemId andFilename:theFilename andVariations:theVariations andFrames:theFrames andConstrained:theConstrained andCurrentVariation:theCurrentVariation];
	}
	return self;
}

-(void)setItemId:(NSInteger)theItemId andFilename:(NSString *)theFilename andVariations:(NSInteger)theVariations andFrames:(NSInteger)theFrames andConstrained:(BOOL)theConstrained andCurrentVariation:(NSInteger)theCurrentVariation {	
	[self setAnimationDuration:ANIMATION_DURATION * 25.0];
	[self setItemId:theItemId];
	[self setVariations:theVariations];
	[self setFilename:theFilename];
	[self setCurrentVariation:theCurrentVariation];
	[self setFrames:theFrames];
	[self setConstrained:theConstrained];
	[self setCurrentVariation:theCurrentVariation];
	[self setContentMode:UIViewContentModeScaleAspectFit];
	[self setUserInteractionEnabled:YES];
	[self setDropped:NO];
	if ([[ItemManager sharedInstance] registerItem:self]) {
		[self displayCurrentImage];
	} else {
		[self setTemporaryImage];
	}
}


-(void)setTemporaryImage {

}


-(void)moveTo:(CGPoint)theCenter {
	[self setCenter:theCenter];
}


-(void)displayImageNotFound {
	[self setImage:nil];
}


-(void)displayCurrentImage {
	NSMutableArray *theAnimFrames = [NSMutableArray arrayWithCapacity:0];
	UIImage *baseFrame = [[ItemManager sharedInstance] imageWithParameters:filename andVariation:currentVariation andFrame:1];
	if (baseFrame) {
		if (frames > 1) {
			[self setImage:nil];
			for (NSInteger i=0; i<frames; i++) {
				UIImage *animFrame = [[ItemManager sharedInstance] imageWithParameters:filename andVariation:currentVariation andFrame:(i+1)];
				if (animFrame) {
					[theAnimFrames addObject:animFrame];
				}
			}
			[self stopAnimating];
			[self setAnimationImages:theAnimFrames];
			[self startAnimating];
		} else {
			[self setImage:baseFrame];
		}
	} else {
		NSLog(@"wtf!!!!!!%@", filename);
	}
}


-(void)drop {
	[self setDropped:YES];
}


-(void)alter {
	if (variations > 1) {
		if (currentVariation++ >= variations) {
			currentVariation = 1;
		}
		UIImage *baseFrame = [[ItemManager sharedInstance] imageWithParameters:filename andVariation:currentVariation andFrame:1];
		[self setImage:baseFrame];
		if (frames > 1) {
			NSMutableArray *theAnimFrames = [NSMutableArray arrayWithCapacity:0];
			for (NSInteger i=0; i<frames; i++) {
				UIImage *animFrame = [[ItemManager sharedInstance] imageWithParameters:filename andVariation:currentVariation andFrame:(i+1)];;
				[theAnimFrames addObject:animFrame];
			}
			[self setAnimationImages:theAnimFrames];
		}
	}
}


-(id)copyWithZone:(NSZone *)zone {
    Item *copy = [[[self class] allocWithZone:zone] initWithItemId:itemId andFilename:filename andVariations:variations andFrames:frames andConstrained:constrained andCurrentVariation:currentVariation];
    return copy;
}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
	if ([super pointInside:point withEvent:event]) {
		if (dropped) {
			UIColor *theColor = [self getPixelColorAtLocation:point];
			CGFloat alpha = CGColorGetAlpha(theColor.CGColor);
			if (alpha == 0.0f) {
				return NO;
			} else {
				return YES;
			}
		} else {
			return YES;
		}
	} else {
		return NO;
	}
}


- (UIColor*) getPixelColorAtLocation:(CGPoint)point {
	UIColor* color = nil;
	CGImageRef inImage = self.image.CGImage;
	// Create off screen bitmap context to draw the image into. Format ARGB is 4 bytes for each pixel: Alpa, Red, Green, Blue
	CGContextRef cgctx = [self copyARGBBitmapContextFromImage:inImage];
	if (cgctx == NULL) { return nil; /* error */ }
	
  size_t w = CGImageGetWidth(inImage);
	size_t h = CGImageGetHeight(inImage);
	CGRect rect = {{0,0},{w,h}}; 
	
	// Draw the image to the bitmap context. Once we draw, the memory
	// allocated for the context for rendering will then contain the
	// raw image data in the specified color space.
	CGContextDrawImage(cgctx, rect, inImage); 
	
	// Now we can get a pointer to the image data associated with the bitmap
	// context.
	unsigned char* data = CGBitmapContextGetData (cgctx);
	if (data != NULL) {
		//offset locates the pixel in the data from x,y.
		//4 for 4 bytes of data per pixel, w is width of one row of data.
		int offset = 4*((w*round(point.y))+round(point.x));
		int alpha =  data[offset];
		int red = data[offset+1];
		int green = data[offset+2];
		int blue = data[offset+3];
		color = [UIColor colorWithRed:(red/255.0f) green:(green/255.0f) blue:(blue/255.0f) alpha:(alpha/255.0f)];
	}
	
	// When finished, release the context
	CGContextRelease(cgctx);
	// Free image data memory for the context
	if (data) { free(data); }
	
	return color;
}

- (CGContextRef) copyARGBBitmapContextFromImage:(CGImageRef) inImage {
	
	CGContextRef    context = NULL;
	CGColorSpaceRef colorSpace;
	void *          bitmapData;
	int             bitmapByteCount;
	int             bitmapBytesPerRow;
	
	// Get image width, height. We'll use the entire image.
	size_t pixelsWide = CGImageGetWidth(inImage);
	size_t pixelsHigh = CGImageGetHeight(inImage);
	
	// Declare the number of bytes per row. Each pixel in the bitmap in this
	// example is represented by 4 bytes; 8 bits each of red, green, blue, and
	// alpha.
	bitmapBytesPerRow   = (pixelsWide * 4);
	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
	
	// Use the generic RGB color space.
	colorSpace = CGColorSpaceCreateDeviceRGB();
	if (colorSpace == NULL)
	{
		fprintf(stderr, "Error allocating color space\n");
		return NULL;
	}
	
	// Allocate memory for image data. This is the destination in memory
	// where any drawing to the bitmap context will be rendered.
	bitmapData = malloc( bitmapByteCount );
	if (bitmapData == NULL)
	{
		fprintf (stderr, "Memory not allocated!");
		CGColorSpaceRelease( colorSpace );
		return NULL;
	}
	
	// Create the bitmap context. We want pre-multiplied ARGB, 8-bits
	// per component. Regardless of what the source image format is
	// (CMYK, Grayscale, and so on) it will be converted over to the format
	// specified here by CGBitmapContextCreate.
	context = CGBitmapContextCreate (bitmapData,
									 pixelsWide,
									 pixelsHigh,
									 8,      // bits per component
									 bitmapBytesPerRow,
									 colorSpace,
									 kCGImageAlphaPremultipliedFirst);
	if (context == NULL)
	{
		free (bitmapData);
		fprintf (stderr, "Context not created!");
	}
	
	// Make sure and release colorspace before returning
	CGColorSpaceRelease( colorSpace );
	
	return context;
}


@end