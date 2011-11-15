// GPL

#import "AnimationSystem.h"
#import "AnimatedPerson.h"


@implementation AnimationSystem


@synthesize avatarPieces;
@synthesize allAvatarPieces;


-(AnimationSystem *)init
{
	if ((self = [super init]))
	{
		[self setPlist:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AnimationSystem" ofType:@"plist"]]];
		[self setLiveCharacters:[NSMutableDictionary dictionaryWithCapacity:0]];
		[UIAccelerometer sharedAccelerometer].delegate = self;

		UIImage *newCheckBoxImage = [UIImage imageNamed:@"ui_check.png"];
		[self setCheckBoxImage:newCheckBoxImage];
		[self setAvatarPieces:[NSArray arrayWithObjects:@"eb", @"eyes", @"mouth", @"body", @"hairul", @"shirt", @"pants", nil]];
		NSMutableArray *allAvatarPiecesTemp = [NSMutableArray arrayWithArray:avatarPieces];
		[allAvatarPiecesTemp addObject:@"hairol"];
		[allAvatarPiecesTemp addObject:@"legs"];
		[self setAllAvatarPieces:allAvatarPiecesTemp];
	}
	return self;
}

@synthesize liveCharacters;
@synthesize plist;
@synthesize myChar;
@synthesize neighbor;
@synthesize lastAcceleration;
@synthesize shakeDetected;
@synthesize body;
@synthesize checkBoxImage;

+(NSDictionary *)skeletons
{
	return [[[AnimationSystem instance] plist] objectForKey:@"Skeletons"];
}

+(NSDictionary *)characters
{
	return [[[AnimationSystem instance] plist] objectForKey:@"Characters"];
}

+(NSArray *)characterNames
{
	NSMutableArray *array = [[[NSMutableArray alloc] init] autorelease];
	for (NSString *key in [[AnimationSystem characters] allKeys])
	{
		if ([[[[AnimationSystem characters] objectForKey:key] objectForKey:@"skeleton"] isEqualToString:@"person"])
		{
			[array addObject:key];
		}
	}
	return array;
}

+(NSDictionary *)loops
{
	return [[[AnimationSystem instance] plist] objectForKey:@"Loops"];
}

+(NSDictionary *)animations
{
	return [[[AnimationSystem instance] plist] objectForKey:@"Animations"];
}

+(NSArray *)randomActions
{
	return [[[AnimationSystem instance] plist] objectForKey:@"RandomActions"];
}

+(NSArray *)myMenuActions
{
	return [[[AnimationSystem instance] plist] objectForKey:@"MyMenuActions"];
}

+(NSArray *)neighborMenuActions
{
	return [[[AnimationSystem instance] plist] objectForKey:@"NeighborMenuActions"];
}

+ (AnimationSystem *)instance  {
	static AnimationSystem *staticInstance;
	@synchronized(self) {
		if(!staticInstance) {
			staticInstance = [[AnimationSystem alloc] init];
		}
	}
	return staticInstance;
}

+(double)getSequenceDuration:(NSString *)theSequence
{
	return [[[[AnimationSystem loops] objectForKey:theSequence] objectForKey:@"duration"] doubleValue];
}

+(NSDictionary *)plist
{
	return [[AnimationSystem instance] plist];
}

- (void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
	if (self.lastAcceleration) {
		if (!histeresisExcited && [AnimationSystem L0AccelerationIsShaking:self.lastAcceleration andCurrent:acceleration andThreshold:0.7]) {
			histeresisExcited = YES;
			[self setShakeDetected:YES];			
		} else if (histeresisExcited && ![AnimationSystem L0AccelerationIsShaking:self.lastAcceleration andCurrent:acceleration andThreshold:0.2]) {
			histeresisExcited = NO;
		}
	}
	
	self.lastAcceleration = acceleration;
}

// Ensures the shake is strong enough on at least two axes before declaring it a shake.
// "Strong enough" means "greater than a client-supplied threshold" in G's.
+(BOOL) L0AccelerationIsShaking:(UIAcceleration*)last andCurrent:(UIAcceleration *) current andThreshold:(double)threshold
{
	double
	deltaX = fabs(last.x - current.x),
	deltaY = fabs(last.y - current.y),
	deltaZ = fabs(last.z - current.z);
	
	return
	(deltaX > threshold && deltaY > threshold) ||
	(deltaX > threshold && deltaZ > threshold) ||
	(deltaY > threshold && deltaZ > threshold);
}

+(NSArray *)eyebrows{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"aseyebrows"]; }
+(NSArray *)eyes{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"aseyes"]; }
+(NSArray *)mouth{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"asmouth"]; }
+(NSArray *)legs{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"aslegs"]; }
+(NSArray *)hairunder{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"ashairunder"]; }
+(NSArray *)hairover{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"ashairover"]; }
+(NSArray *)shirt{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"asshirt"]; }
+(NSArray *)pants{ return [[NSUserDefaults standardUserDefaults] objectForKey:@"aslegs"]; }

+(NSString *)formatAvatarImageNameForCharacter:(NSString *)theCharacterName andSkeletonPiece:(NSString *)theSkeletonPiece andAnimationName:(NSString *)theAnimationName andFrame:(NSInteger)theFrame
{
	return [NSString stringWithFormat:@"%@_%@_%@%04i", theCharacterName, theSkeletonPiece, theAnimationName, theFrame];
}

+(NSArray *)getAvatarItemsForPiece:(NSString *)thePiece
{
	assert(NO);
}

+(void)initializeAvatarSelection
{
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	NSArray *allPieces = [[AnimationSystem instance] allAvatarPieces];
	for (NSString *piece in allPieces)
	{
		NSString *pieceListName = piece;
		NSArray *pieceList = [[[[AnimationSystem instance] plist] objectForKey:@"avatar_elements"] objectForKey:piece];
		[defs setObject:pieceList forKey:pieceListName];
	}
	[defs synchronize];
}

-(void)dealloc
{
	[self setLastAcceleration:nil];
	[plist release];
	[liveCharacters release];
	[self setMyChar:nil];
	[self setNeighbor:nil];
	[self setCheckBoxImage:nil];
	[self setAllAvatarPieces:nil];
	[self setAvatarPieces:nil];
	[self setBody:nil];
	[super dealloc];
}

@end
