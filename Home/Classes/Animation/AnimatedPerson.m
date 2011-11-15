// GPL

#import "AnimatedPerson.h"
#import "AnimationSystem.h"
#import "PointObject.h"

@implementation AnimatedPerson

@synthesize character;
@synthesize eyebrows;
@synthesize eyes;
@synthesize mouth;
@synthesize body;
@synthesize hair;
@synthesize shirt;
@synthesize pants;
@synthesize currentLoop;
@synthesize selectedAction;
@synthesize view;
@synthesize status;
@synthesize statusBubble;
@synthesize enableInteractions;
@synthesize currentAnimationSequence;
@synthesize actionsMenu;
@synthesize enableChangeMe;
@synthesize enableAnimations;
@synthesize animations;
@synthesize singleClickAction;
@synthesize mySimpleType;

-(void)dealloc
{
	NSLog(@"AnimatedPerson::dealloc");
	[self setSingleClickAction:nil];
	[character release];
	
	[statusBubble release];

	[self setEyes:nil];
	[self setEyebrows:nil];
	[self setMouth:nil];
	[self setBody:nil];
	[self setHair:nil];
	[self setShirt:nil];
	[self setPants:nil];
	[self setCurrentLoop:nil];
	[self setSelectedAction:nil];
	[self setStatus:nil];
	[self setCurrentAnimationSequence:nil];
	[self setActionsMenu:nil];
	[self setAnimations:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[self setView:nil];
	[super dealloc];
}



-(id)initWithEyebrows:(NSString *)theEyebrows
			  andEyes:(NSString *)theEyes
			 andMouth:(NSString *)theMouth
			  andBody:(NSString *)theBody
			  andHair:(NSString *)theHair
			 andShirt:(NSString *)theShirt
			 andPants:(NSString *)thePants
			andOrigin:(CGPoint)theOrigin
			  andView:(UIView *)theView
{
	if ((self = [super init]))
	{
		[self setEyebrows:theEyebrows];
		[self setEyes:theEyes];
		[self setMouth:theMouth];
		[self setBody:theBody];
		[self setHair:theHair];
		[self setShirt:theShirt];
		[self setPants:thePants];
		[self setCurrentLoop:@"start"];
		NSArray *pieces = [[NSArray alloc] initWithObjects:[self hair], [self body], [self pants], [self body], [self shirt], [self mouth], [self eyes], [self eyebrows], [self hair], nil];
		AnimatedObject *theChar = [[AnimatedObject alloc] initWithSkeleton:@"avatar"
											 andCharactersForSkeletonPieces:pieces
																  andOrigin:theOrigin
														andDefaultAnimation:@"start"];
		[pieces release];
		[theChar setClickTarget:self];
		[theChar setSingleClickAction:@selector(handleSingleClick)];
		[self setCharacter:theChar];
		[theChar release];
		[self restartAnimation];
		[self setView:theView];
		[self setStatus:nil];
		[self setStatusBubble:nil];
		[self setEnableInteractions:YES];
		currentAnimationStep = -1;
		isFlipped = NO;
		[self setEnableChangeMe:YES];
		[self setActionsMenu:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleNavigateNotification:) name:@"avatar" object: nil];
		[self setSingleClickAction:@"changeAvatar"];
	}
	return self;
}

-(void)handleNavigateNotification:(NSNotification *)theNotification
{
	NSDictionary *userInfo = [theNotification userInfo];
	NSString *action = [userInfo objectForKey:@"action"];
	if (action != nil && [action isEqualToString:@"changeSkeletonPiece"])
	{
		NSString *piece = [userInfo objectForKey:@"piece"];
		NSString *value = [userInfo objectForKey:@"value"];
		if (!piece || !value)
		{
		}
		else if ([piece isEqualToString:@"hairul"])
		{
			[self changeHair:value];
		}
		else if ([piece isEqualToString:@"eyes"])
		{
			[self changeEyes:value];
		}
		else if ([piece isEqualToString:@"eb"])
		{
			[self changeEyebrows:value];
		}
		else if ([piece isEqualToString:@"mouth"])
		{
			[self changeMouth:value];
		}
		else if ([piece isEqualToString:@"body"])
		{
			[self changeBody:value];
		}
		else if ([piece isEqualToString:@"shirt"])
		{
			[self changeShirt:value];
		}
		else if ([piece isEqualToString:@"pants"])
		{
			[self changePants:value];
		}
		[[NSUserDefaults standardUserDefaults] setObject:value forKey:[NSString stringWithFormat:@"def%@", piece]];
	}
}

-(void)playLoop:(NSString *)theLoopName
{
	[self setCurrentLoop:theLoopName];
	[character playLoop:[self currentLoop] andRepeatCount:1];
}

-(void)changeEyebrows:(NSString *)theEyebrows
{
	[character changeSelectedCharacter:theEyebrows forSkeletonPiece:@"eb"];
	[self setEyebrows:theEyebrows];
	[self restartAnimation];
}

-(void)changeEyes:(NSString *)theEyes
{
	[character changeSelectedCharacter:theEyes forSkeletonPiece:@"eyes"];
	[self setEyes:theEyes];
	[self restartAnimation];
}

-(void)changeMouth:(NSString *)theMouth
{
	[character changeSelectedCharacter:theMouth forSkeletonPiece:@"mouth"];
	[self setMouth:theMouth];
	[self restartAnimation];
}

-(void)changeBody:(NSString *)theBody
{
	[character changeSelectedCharacter:theBody forSkeletonPiece:@"body"];
	[character changeSelectedCharacter:theBody forSkeletonPiece:@"legs"];
	[self setBody:theBody];
	[self restartAnimation];
}

-(void)changeHair:(NSString *)theHair
{
	[character changeSelectedCharacter:theHair forSkeletonPiece:@"hairul"];
	[character changeSelectedCharacter:theHair forSkeletonPiece:@"hairol"];
	[self setHair:theHair];
	[self restartAnimation];
}

-(void)changeShirt:(NSString *)theShirt
{
	[character changeSelectedCharacter:theShirt forSkeletonPiece:@"shirt"];
	[self setShirt:theShirt];
	[self restartAnimation];
}

-(void)changePants:(NSString *)thePants
{
	[character changeSelectedCharacter:thePants forSkeletonPiece:@"pants"];
	[self setPants:thePants];
	[self restartAnimation];
}

-(void)restartAnimation
{
}

-(void)updateStatus:(NSString *)theStatus
{
	[self setStatus:theStatus];
	[self setStatusBubbleHidden:NO];
	[statusBubble setStatus:theStatus];
}

-(void)setStatusBubbleHidden:(BOOL)hidden
{
	if (hidden)
	{		
		if (statusBubble)
		{
			[statusBubble removeFromSuperview];
			[statusBubble release];
			statusBubble = nil;
		}	
	}
	else
	{
		if (enableInteractions)
		{
			if (!statusBubble)
			{
				CGRect frame = [character frame];
				frame.origin.x += 75;
				frame.origin.y += 60;
				StatusBubble *newStatusBubble = [[StatusBubble alloc] initWithOrigin:frame.origin andTarget:self andClickAction:@selector(handleStatusBubbleClicked)];
				[self setStatusBubble:newStatusBubble];
				[newStatusBubble release];
				if (view) {
					[view insertSubview:statusBubble belowSubview:character];
				} else {
					[[character superview] insertSubview:statusBubble belowSubview:character];
				}
			}
		}
	}
}

-(void)doChangeMe
{
	[self hideActionsMenu];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"changeAvatar" object:self userInfo:nil];
	[self setSelectedAction:@"ChangeMe"];
//	if (enableInteractions && isChangeMeEnabled)
	{
//		[self playAnimation:@"walkAndHighFive"];
	}
}

-(void)showAnimationMenu
{
	if (enableInteractions)
	{
		ActionsViewController *newActionsMenu = [[[ActionsViewController alloc] initWithAnimatedPerson:self] autorelease];
		[self setActionsMenu:newActionsMenu];
		[view addSubview:[actionsMenu view]];
		CGRect frame = [[actionsMenu view] frame];
		frame.origin.x = 140;
		frame.origin.y = 40;
		[[actionsMenu view] setFrame:frame];
		[self setEnableInteractions:NO];
	}
}

-(void)handleSingleClick
{
	if ([singleClickAction isEqualToString:@"showAnimationMenu"])
	{
		[self showAnimationMenu];
	}
	else
	{
		[[NSNotificationCenter defaultCenter] postNotificationName:singleClickAction object:self userInfo:nil];
	}
}

-(void)hideActionsMenu
{
	if (actionsMenu)
	{
		[[actionsMenu view] removeFromSuperview];
		[self setActionsMenu:nil];
		[self setEnableInteractions:YES];
	}
}

-(void)handleStatusBubbleClicked
{
	if (enableInteractions)
	{
		[self setSelectedAction:@"MyStatus"];
	}
}

-(void)doDragWithMovement:(PointObject *)theMovement
{
	CGRect newFrame = [character frame];
	newFrame.origin.x += [theMovement point].x;
	newFrame.origin.y += [theMovement point].y;
	[character setFrame:newFrame];
	CGRect newStatusFrame = [statusBubble frame];
	newStatusFrame.origin.x += [theMovement point].x;
	newStatusFrame.origin.y += [theMovement point].y;
	[statusBubble setFrame:newStatusFrame];
}

-(void)playAnimation:(NSString *)animationName
{
	if (currentAnimationSequence == nil)
	{
		NSArray *animationSequence = [[AnimationSystem animations] objectForKey:animationName];
		if (animationSequence)
		{
			[self setCurrentAnimationSequence:animationSequence];
			currentAnimationStep = 0;
			[self playNextStepInSequence];
		}
	}
}

-(void)playNextStepInSequence
{
	if (currentAnimationStep < [currentAnimationSequence count])
	{
		NSDictionary *step = [currentAnimationSequence objectAtIndex:currentAnimationStep];
		NSString *sequence = [step objectForKey:@"sequence"];
		double loopDuration = [[[[AnimationSystem loops] objectForKey:sequence] objectForKey:@"duration"] doubleValue];
		double duration = [[step objectForKey:@"duration"] doubleValue];
		int repeatCount = duration / loopDuration;
		if (sequence && duration > 0)
		{
			[character playLoop:sequence andRepeatCount:repeatCount];
		}
		int dx = [[step objectForKey:@"dx"] intValue];
		int dy = [[step objectForKey:@"dy"] intValue];
		BOOL flip = NO;
		if ([step objectForKey:@"flip"] != nil)
		{
			flip = [[step objectForKey:@"flip"] boolValue];
		}
		if (flip)
		{
			isFlipped = !isFlipped;
		}
		CGFloat sx = isFlipped ? -1.0 : 1.0;
		CGFloat sy = 1.0;
		if (flip)
		{
			[character moveWithDx:0 andDy:0 andDuration:0 andSx:sx andSy:sy];
		}
		[character moveWithDx:dx andDy:dy andDuration:duration andSx:sx andSy:sy];
		currentAnimationStep++;
		[self performSelector:@selector(playNextStepInSequence) withObject:nil afterDelay:duration];
	}
	else
	{
		[self finishSequence];
	}
}

-(void)finishSequence
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(playNextStepInSequence) object:nil];
	if (currentAnimationSequence)
	{
		[currentLoop release];
		[self setCurrentAnimationSequence:nil];
		currentAnimationStep = -1;
	}
}

+(AnimatedPerson *)loadCharacterWithEyebrows:(NSString *)theEyebrows
									 andEyes:(NSString *)theEyes
									andMouth:(NSString *)theMouth
									 andBody:(NSString *)theBody
									 andHair:(NSString *)theHair
									andShirt:(NSString *)theShirt
									andPants:(NSString *)thePants
									intoView:(UIView *)theView
								   belowView:(UIView *)theBelowView
								 andObserver:(id)theObserver
								   andOrigin:(CGPoint)theOrigin
						   andEnableChangeMe:(BOOL)theEnableChangeMe
						 andEnableAnimations:(BOOL)theEnableAnimations
							   andAnimations:(NSArray *)theAnimations
{
	AnimatedPerson *theChar = [[[AnimatedPerson alloc] initWithEyebrows:theEyebrows andEyes:theEyes andMouth:theMouth andBody:theBody andHair:theHair andShirt:theShirt andPants:thePants andOrigin:theOrigin andView:theView] autorelease];
	[theChar setEnableChangeMe:theEnableChangeMe];
	[theChar setEnableAnimations:theEnableAnimations];
	[theChar setAnimations:theAnimations];
	if (theBelowView)
	{
		[theView insertSubview:[theChar character] belowSubview:theBelowView];
	}
	else
	{
		[theView addSubview:[theChar character]];
	}
	if (theObserver)
	{
		[theChar addObserver:theObserver forKeyPath:@"selectedAction" options:NSKeyValueObservingOptionNew context:nil];
	}
	return theChar;
}


-(void)setHidden:(BOOL)hidden
{
	if (hidden)
	{
		[character setHidden:YES];
		[statusBubble setHidden:YES];
	}
	else
	{
		[character setHidden:NO];
		[statusBubble setHidden:NO];
	}
}


@end
