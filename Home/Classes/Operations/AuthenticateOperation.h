// GPL

#import <Foundation/Foundation.h>
#import "Operation.h"


@interface AuthenticateOperation : Operation {
	NSString *password;
	NSString *deviceToken;
	NSMutableArray *items;
	NSMutableDictionary *friends;
  Score *score;
  Avatar *avatar;
}


@property (retain) NSString *password;
@property (retain) NSString *deviceToken;
@property (retain) NSMutableArray *items;
@property (retain) NSMutableDictionary *friends;
@property (retain) Score *score;
@property (retain) Avatar *avatar;


@end
