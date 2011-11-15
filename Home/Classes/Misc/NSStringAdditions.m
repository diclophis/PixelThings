#import "NSStringAdditions.h"


static NSDateFormatter *dateFormatterInstance = NULL;

@implementation NSString (NSStringAdditions)



+ (NSString*) stringWithUUID {
	CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
	//get the string representation of the UUID
	NSString *uuidString = (NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return [uuidString autorelease];
}

-(BOOL)validatesAsEmailAddress {
	NSRange atRange = [self rangeOfString:@"@"];
	NSRange dotRange = [self rangeOfString:@"."];
	if (atRange.location == NSNotFound || dotRange.location == NSNotFound) {
		return NO;
	} else {
		return YES;
	}
}


+(NSDateFormatter *)sharedDateFormatter {
    @synchronized(self) {
		if (dateFormatterInstance == NULL) {
			dateFormatterInstance = [[NSDateFormatter alloc] init];
			[dateFormatterInstance setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
		}
	}
    return dateFormatterInstance;
}

-(NSDate *)date {
	NSDate *date;
	date = [[NSString sharedDateFormatter] dateFromString:[self stringByReplacingOccurrencesOfString:@"UTC" withString:@"GMT"]];
	return date;
}


@end
