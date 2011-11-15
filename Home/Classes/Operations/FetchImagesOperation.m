// GPL


#import "FetchImagesOperation.h"
#import "Item.h"

@implementation FetchImagesOperation


@synthesize myItemName;
@synthesize myMissingFilenames;


-(void)dealloc {
	[myItemName release];
	[myMissingFilenames release];
	[super dealloc];
}


-(id)initWithItemName:(NSString *)theItemName andMissingFilenames:(NSMutableArray *)theMissingFilenames {
	if ((self = [super init])) {
		[self setMyItemName:theItemName];
		[self setMyMissingFilenames:theMissingFilenames];
	}
	return self;
}


-(void)main {
	@try {
		if ([self connect]) {
      
			BOOL foundAll = YES;
			NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			if (!documentsDirectory) {
				NSLog(@"Documents directory not found!");
			}
			
			for (NSString *filename in [myMissingFilenames reverseObjectEnumerator]) {
				if ([self isCancelled]) {
					foundAll = NO;
				}
								
				//NSString *url = @"http://placekitten.com.s3.amazonaws.com/homepage-samples/200/138.jpg"; //[NSString stringWithFormat:@"%@/images/%@", @"http://DEADwhatthefuck.com", filename];
				NSString *url = [NSString stringWithFormat:@"http://risingcode.com/button/%@", filename]; //[NSString stringWithFormat:@"%@/images/%@", @"http://DEADwhatthefuck.com", filename];
				NSString *filenameToSave = [documentsDirectory stringByAppendingPathComponent:filename];
				NSError *error = nil;
				NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url] options:NSDataReadingMapped error:&error];
				if (error) {
					NSLog(@"didnot: %@ %@", url, [error localizedFailureReason]);
					foundAll = NO;
				} else {
					if ([data length]) {
						[[[ItemManager sharedInstance] myDatas] setObject:data forKey:filename];
						[data writeToFile:filenameToSave atomically:YES];
					} else {
						foundAll = NO;
					}
				}
			}
			[self setSuccess:foundAll && ![self isCancelled]];
		}
	}
	
	@catch (id theException) {
		NSLog(@"wtf: %@", theException);
		[self setErrorMessage:@"Unable to fetch image, please try again"];
	}
}


@end