// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface PurchaseItemOperation : Operation {
	FunItem *item;
}


@property (retain) FunItem *item;


-(id)initWithItem:(FunItem *)theItem;

@end