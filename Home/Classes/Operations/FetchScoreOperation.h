// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@interface FetchScoreOperation : Operation {
	Score *score;
}


@property (retain) Score *score;


@end