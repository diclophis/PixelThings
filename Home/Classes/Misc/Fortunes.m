// GPL

#import "Fortunes.h"


@implementation Fortunes


+(NSString *)randomFortune {
	NSArray *fortunes = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Fortunes" ofType:@"plist"]];
	srandom(time(NULL));
	NSInteger r = (random() % [fortunes count]);
	NSString *fortune = [[fortunes objectAtIndex:r] copy];
	return [fortune autorelease];
}


@end
