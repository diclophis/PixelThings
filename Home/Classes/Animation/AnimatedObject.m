// GPL

#import "AnimatedObject.h"
#import "AnimationSystem.h"
#import "Item.h"


@implementation AnimatedObject


@synthesize skeletonName;
@synthesize charactersForSkeletonPieces;
@synthesize animatedImageViews;
@synthesize defaultAnimation;
@synthesize currentAnimationName;
@synthesize clickableView;


-(id)initWithSkeleton:(NSString *)theSkeletonName andCharactersForSkeletonPieces:(NSArray *)theCharactersForSkeletonPieces andOrigin:(CGPoint)theOrigin andDefaultAnimation:(NSString *)theDefaultAnimation
{
	[self setSkeletonName:theSkeletonName];
	if ((self = [super initWithFrame:CGRectMake(theOrigin.x, theOrigin.y, [self getSkeletonParameter:@"width"], [self getSkeletonParameter:@"height"])]))
	{
		NSMutableDictionary *dic = [[[NSMutableDictionary alloc] init] autorelease];
		[self setCharactersForSkeletonPieces:dic];
		int iChar = 0;
		[self setAnimatedImageViews:[NSMutableArray arrayWithCapacity:[[self getSkeletonPieces] count]]];
		[self setDefaultAnimation:theDefaultAnimation];
		ClickableView *theClickableView = [[ClickableView alloc] init];
		CGRect clickableFrame = [theClickableView frame];
		clickableFrame.size.width = [self getSkeletonParameter:@"clickableWidth"];
		clickableFrame.size.height = [self getSkeletonParameter:@"clickableHeight"];
		clickableFrame.origin.x = 75;
		clickableFrame.origin.y = 50;
		[self setClickableView:theClickableView];
		[theClickableView release];
		
		[clickableView setFrame:clickableFrame];
		[self addSubview:clickableView];
		for (NSString *skeletonPiece in [self getSkeletonPieces])
		{
			NSString *character = [theCharactersForSkeletonPieces objectAtIndex:iChar];
			[dic setValue:character forKey:skeletonPiece];
			iChar++;
			if (theDefaultAnimation)
			{
        UIImageView *imageView;
				imageView = [self loadDefaultImageForSkeletonPiece:skeletonPiece];
        [imageView setContentMode:UIViewContentModeScaleToFill];
        [self addSubview:imageView];
        [animatedImageViews addObject:imageView];
        [imageView release];
			}
		}
		[self setCurrentAnimationName:nil];
	}
	return self;
}

-(void)test
{
	[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(testLoop) userInfo:nil repeats:YES];
}

-(void)playLoop:(NSString *)theLoop andRepeatCount:(int)theRepeatCount
{
	
	[self stopAnimating];
	NSArray *skeletonPieces = [self getSkeletonPieces];
	if (!skeletonPieces) {
		assert(NO);
		return;
	}
	int numberOfFrames = [[[[AnimationSystem loops] objectForKey:theLoop] objectForKey:@"frames"] intValue];
	double duration = [[[[AnimationSystem loops] objectForKey:theLoop] objectForKey:@"duration"] doubleValue];
	for (int iSkeletonPiece = 0; iSkeletonPiece < [skeletonPieces count]; iSkeletonPiece++) {
		NSString *skeletonPiece = [skeletonPieces objectAtIndex:iSkeletonPiece];
		UIImageView *imageView = [animatedImageViews objectAtIndex:iSkeletonPiece];		
		NSMutableArray *imgs = [NSMutableArray arrayWithCapacity:numberOfFrames];
		NSString *characterName = [[self charactersForSkeletonPieces] objectForKey:skeletonPiece];
		for (int iFrame = 0; iFrame < numberOfFrames; iFrame++)
		{
			
			NSString *imageName = [AnimationSystem formatAvatarImageNameForCharacter:characterName andSkeletonPiece:skeletonPiece andAnimationName:theLoop andFrame:iFrame];
			UIImage *img;
			if ([skeletonPiece isEqualToString:@"eyes"] || [skeletonPiece isEqualToString:@"eb"] || [skeletonPiece isEqualToString:@"mouth"])
			{
				img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blank" ofType:@"png"]];
			}
			else
			{
				img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
				
				if (!img)
				{
					img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"blank" ofType:@"png"]];
				}
			}
			[imgs addObject:img];
		}
		 
		
		[imageView stopAnimating];
		[imageView stopAnimating];
		if (imageView.animationImages != nil){
			[imageView.animationImages release];
		}
		[imageView setAnimationImages:imgs];
	}
	
	for (UIImageView *iv in animatedImageViews) {
		[iv setAnimationDuration: duration];
		[iv setAnimationRepeatCount: theRepeatCount];
		[iv startAnimating];
	}
	
	[self setCurrentAnimationName:theLoop];
}


-(UIImageView *)loadDefaultImageForSkeletonPiece:(NSString *)skeletonPiece {
	//NSString *characterName = [[self charactersForSkeletonPieces] objectForKey:skeletonPiece];
	//NSString *defaultImageName = [AnimationSystem formatAvatarImageNameForCharacter:characterName andSkeletonPiece:skeletonPiece andAnimationName:defaultAnimation andFrame:0];
	Item *item;
	item = [[[Item alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height)] autorelease];
	[item setItemId:@"1" andFilename:skeletonPiece andVariations:1 andFrames:1 andConstrained:NO andCurrentVariation:0];
	return item;
}


-(void)moveWithDx:(int)theDx andDy:(int)theDy andDuration:(int)theDuration andSx:(CGFloat)sx andSy:(CGFloat)sy {
	//TODO
}


-(void)stopAnimating {
	if (currentAnimationName) {
		for (UIImageView *iv in animatedImageViews) {
			[iv stopAnimating];
		}
		[self setCurrentAnimationName:nil];
	}
}


-(int)getSkeletonParameter:(NSString *)theParameterName {
	return [[[[AnimationSystem skeletons] objectForKey:skeletonName] objectForKey:theParameterName] intValue];
}


-(NSArray *)getSkeletonPieces {
	return [[[AnimationSystem skeletons] objectForKey:skeletonName] objectForKey:@"pieces"];
}


-(void)changeSelectedCharacter:(NSString *)theCharacter forSkeletonPiece:(NSString *)theSkeletonPiece {
	[charactersForSkeletonPieces setObject:theCharacter forKey:theSkeletonPiece];
	//int skeletonPieceIndex = [[self getSkeletonPieces] indexOfObject:theSkeletonPiece];
	//UIImageView *imageviewForSkeletonPiece = [animatedImageViews objectAtIndex:skeletonPieceIndex];
	//imageviewForSkeletonPiece = [self loadDefaultImageForSkeletonPiece:theSkeletonPiece];
}


-(void)setClickTarget:(id)target {
	[clickableView setTarget:target];
}


-(void)setSingleClickAction:(SEL)singleClickAction {
	[clickableView setSingleClickAction:singleClickAction];
}


-(void)setDoubleClickAction:(SEL)doubleClickAction {
	[clickableView setDoubleClickAction:doubleClickAction];
}


-(void)dealloc {
	NSLog(@"AnimatedObject::dealloc");
	[self stopAnimating];
	[self removeFromSuperview];
	for (UIImageView *iv in animatedImageViews) {
		[iv removeFromSuperview];
		[iv setImage:nil];
	}
	[animatedImageViews removeAllObjects];
	[self setAnimatedImageViews:nil];
	[self setCharactersForSkeletonPieces:nil];
	[self setSkeletonName:nil];
	[self setDefaultAnimation:nil];
	[self setCurrentAnimationName:nil];
	[self setClickableView:nil];
	[super dealloc];
}

@end