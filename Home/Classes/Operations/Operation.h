// GPL

#import <Foundation/Foundation.h>
#import "Parse/Parse.h"


@class ParseClient;


@interface Operation : NSOperation {
	NSNumber *progress;
	BOOL success;
	BOOL hasDelegate;
	BOOL indicatesProgress;
	NSString *operationDescription;
	NSString *errorMessage;
	BOOL recoverable;
	NSUserDefaults *dflts;
	NSString *username;
	NSString *deviceIdentifier;
  ParseClient *client;
}


@property BOOL success;
@property BOOL hasDelegate;
@property BOOL indicatesProgress;
@property BOOL recoverable;
@property (retain) NSNumber *progress;
@property (retain) NSString *operationDescription;
@property (retain) NSString *errorMessage;
@property (retain) NSUserDefaults *dflts;
@property (retain) NSString *username;
@property (retain) NSString *deviceIdentifier;
@property (retain) ParseClient *client;


-(BOOL)allDependenciesSuccessful;
-(BOOL)connect;
-(void)abortOperation:(id)userData;


@end
