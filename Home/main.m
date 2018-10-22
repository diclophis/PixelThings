// GPL

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "parse_keys.h"

@interface PFInternalUtils : NSObject
+ (void)setParseServer:(NSString *)server;
@end

@implementation PFInternalUtils(WangChung)
+ (NSString *)parseServerURLString {
    return @"http://kicksass-db.app.dev.mavenlink.net/1";
}
@end


int main(int argc, char *argv[]) {
    [Parse setApplicationId:PARSE_APPLICATION_ID clientKey:PARSE_MASTER_KEY];
    //[Parse setVersion:1];
    //NSLog([Parse getApplicationId]);
    //NSLog([Parse getClientKey]);
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
    [pool release];
    return retVal;
}