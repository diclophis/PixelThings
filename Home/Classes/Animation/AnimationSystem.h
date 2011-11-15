// GPL

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AnimatedPerson;


@interface AnimationSystem : NSObject<UIAccelerometerDelegate> {
	NSMutableDictionary *liveCharacters;
	NSDictionary *plist;
	AnimatedPerson *myChar;
	AnimatedPerson *neighbor;
	BOOL histeresisExcited;
	UIAcceleration* lastAcceleration;
	BOOL shakeDetected;
	NSArray *body;
	UIImage *checkBoxImage;
	NSArray *avatarPieces;
	NSArray *allAvatarPieces;
}

@property (nonatomic, retain) NSMutableDictionary *liveCharacters;
@property (nonatomic, retain) NSDictionary *plist;
@property (nonatomic, retain) AnimatedPerson *myChar;
@property (nonatomic, retain) AnimatedPerson *neighbor;
@property (retain) UIAcceleration* lastAcceleration;
@property BOOL shakeDetected;
@property (nonatomic, retain) NSArray *body;
@property (nonatomic, retain) UIImage *checkBoxImage;
@property (nonatomic, retain) NSArray *avatarPieces;
@property (nonatomic, retain) NSArray *allAvatarPieces;

+(BOOL) L0AccelerationIsShaking:(UIAcceleration*)last andCurrent:(UIAcceleration *) current andThreshold:(double)threshold;

-(AnimationSystem *)init;

+(NSDictionary *)skeletons;
+(NSArray *)characterNames;
+(NSDictionary *)characters;
+(NSDictionary *)loops;
+(NSDictionary *)animations;
+(NSArray *)randomActions;
+(NSArray *)myMenuActions;
+(NSArray *)neighborMenuActions;
+(AnimationSystem *)instance;
+(NSDictionary *)plist;
+(NSString *)formatAvatarImageNameForCharacter:(NSString *)theCharacterName andSkeletonPiece:(NSString *)theSkeletonPiece andAnimationName:(NSString *)theAnimationName andFrame:(NSInteger)theFrame;

+(NSArray *)getAvatarItemsForPiece:(NSString *)thePiece;

+(NSArray *)eyebrows;
+(NSArray *)eyes;
+(NSArray *)mouth;
+(NSArray *)legs;
+(NSArray *)hairunder;
+(NSArray *)hairover;
+(NSArray *)shirt;
+(NSArray *)pants;

+(void)initializeAvatarSelection;


@end