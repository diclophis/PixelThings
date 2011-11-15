// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


static const CGFloat itemWidth = 100.0f;
static const CGFloat itemHeight = 75.0f;
static const CGFloat gutter = 10.0f;


@interface Item : UIImageView <NSCopying> {
	NSInteger currentVariation;
	NSInteger itemId;
	BOOL dropped;
	NSString *filename;
	NSInteger variations;
	NSInteger frames;
	BOOL constrained;
}


@property NSInteger itemId;
@property (retain) NSString *filename;
@property NSInteger currentVariation;
@property NSInteger variations;
@property NSInteger frames;
@property BOOL dropped;
@property BOOL constrained;


-(id)initWithItemId:(NSInteger)theItemId andFilename:(NSString *)theFilename andVariations:(NSInteger)theVariations andFrames:(NSInteger)theFrames andConstrained:(BOOL)theConstrained andCurrentVariation:(NSInteger)theCurrentVariation;
-(void)setItemId:(NSInteger)theItemId andFilename:(NSString *)theFilename andVariations:(NSInteger)theVariations andFrames:(NSInteger)theFrames andConstrained:(BOOL)theConstrained andCurrentVariation:(NSInteger)theCurrentVariation;

-(void)alter;
-(void)drop;
-(CGContextRef)copyARGBBitmapContextFromImage:(CGImageRef)inImage;
-(UIColor *)getPixelColorAtLocation:(CGPoint)point;
-(void)moveTo:(CGPoint)theCenter;
-(void)setTemporaryImage;
-(void)displayCurrentImage;
-(void)displayImageNotFound;

@end


@interface ItemManager : NSObject <ItemDownloaderDelegate> {
	NSString *myDocumentsDirectory;
	NSMutableDictionary *myVisibleItems;
	NSMutableDictionary *myMissingFilesForItem;
	NSMutableDictionary *myDatas;
}


@property (retain) NSString *myDocumentsDirectory;
@property (retain) NSMutableDictionary *myVisibleItems;
@property (retain) NSMutableDictionary *myMissingFilesForItem;
@property (retain) NSMutableDictionary *myDatas;

+(ItemManager *)sharedInstance;
-(NSMutableArray *)missingFilenamesForItem:(Item *)theItem;
-(BOOL)registerItem:(Item *)theItem;
-(UIImage *)imageWithParameters:(NSString *)thePrefix andVariation:(NSInteger)theVariation andFrame:(NSInteger)theFrame;


@end