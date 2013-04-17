// GPL

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"
#import "parse_keys.h"

int main(int argc, char *argv[]) {
  [Parse setApplicationId:PARSE_APPLICATION_ID clientKey:PARSE_CLIENT_KEY];
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int retVal = UIApplicationMain(argc, argv, nil, @"AppDelegate");
  [pool release];
  return retVal;
}