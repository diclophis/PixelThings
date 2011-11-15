// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchImagesOperation : Operation {
	NSString *myItemName;
	NSMutableArray *myMissingFilenames;
}


@property (retain) NSString *myItemName;
@property (retain) NSMutableArray *myMissingFilenames;


-(id)initWithItemName:(NSString *)theItemName andMissingFilenames:(NSMutableArray *)theMissingFilenames;


@end