#import <Foundation/Foundation.h>


@interface NSString (NSStringAdditions)

+(NSDateFormatter *)sharedDateFormatter;

+ (NSString*) stringWithUUID;
-(BOOL)validatesAsEmailAddress;
-(NSDate *)date;

@end
