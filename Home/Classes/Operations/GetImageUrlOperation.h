// GPL

#import <Foundation/Foundation.h>
#import "SimpleOperation.h"

@interface GetImageUrlOperation : SimpleOperation {

	NSString *name;
	NSString *url;
}

-(GetImageUrlOperation*)initWithName:(NSString *)theName;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *url;

@end
