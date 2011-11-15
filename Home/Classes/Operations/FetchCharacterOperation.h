// GPL


#import <Foundation/Foundation.h>
#import "Operation.h"


@class Character;


@interface FetchCharacterOperation : Operation {
	Character *character;
}


@property (retain) Character *character;


@end
