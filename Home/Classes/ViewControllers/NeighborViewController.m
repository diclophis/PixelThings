// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Avatar.h"
#import "Item.h"
#import "NeighborMenuViewController.h"
#import "OperationsManager.h"
#import "AnimationSystem.h"
#import "AnimatedPerson.h"
#import "RoomViewController.h"
#import "NeighborViewController.h"


@implementation NeighborViewController


@synthesize imageView;
@synthesize score;
@synthesize roomView;
@synthesize modulator;


-(id)init {
	if ((self = [super initWithNibName:@"NeighborViewController" bundle:[NSBundle mainBundle]])) {
		RoomViewController *theRoomView = [[RoomViewController alloc] init];
		[self setRoomView:theRoomView];
		[theRoomView release];
		modulator = 1;
	}
	return self;
}


-(void)dealloc {
	if ([[AnimationSystem instance] neighbor])
	{
		[[[[AnimationSystem instance] neighbor] statusBubble] removeFromSuperview];
		[[[[AnimationSystem instance] neighbor] character] removeFromSuperview];
		[[[[AnimationSystem instance] neighbor] character] setClickTarget:nil];
		[[AnimationSystem instance] setNeighbor:nil];
	}
	[score release];
	[imageView release];
	[roomView release];
	[super dealloc];
}


-(void)viewDidLoad {
	[[OperationsManager sharedInstance] setAvatarViewingDelegate:self];
	[[OperationsManager sharedInstance] fetchRandomFriendsRoom];
	[[self view] setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 0.0f)];
	[[self view] addSubview:[roomView view]];
}


-(void)viewWillAppear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];

}


-(void)viewWillDisappear:(BOOL)animated {
	[[OperationsManager sharedInstance] setAvatarViewingDelegate:nil];
	[[self view] setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 320.0f)];
}


-(void)didFetchRoom:(NSMutableArray *)theItems andScore:(Score *)theScore andAvatar:(Avatar *)theAvatar {
	
	if ([[AnimationSystem instance] neighbor])
	{
		[[[[AnimationSystem instance] neighbor] statusBubble] removeFromSuperview];
		[[[[AnimationSystem instance] neighbor] character] removeFromSuperview];
		[[[[AnimationSystem instance] neighbor] character] setClickTarget:nil];		
	}
	
	AnimatedPerson *neighbor = [AnimatedPerson loadCharacterWithEyebrows:[theAvatar eyebrows]
																 andEyes:[theAvatar eyes]
																andMouth:[theAvatar mouth]
																 andBody:[theAvatar body]
																 andHair:[theAvatar hair]
																andShirt:[theAvatar shirt]
																andPants:[theAvatar pants]
																intoView:[self view]
															   belowView:nil
															 andObserver:nil
															   andOrigin:CGPointMake(310,68)
													   andEnableChangeMe:NO
													 andEnableAnimations:YES
														   andAnimations:[AnimationSystem neighborMenuActions]];
	 
	
	[neighbor setSingleClickAction:@"showAnimationMenu"];
	[[AnimationSystem instance] setNeighbor:neighbor];

	[[[AnimationSystem instance] neighbor] updateStatus:[theAvatar status]];
	[neighbor release];
	 
	[self setScore:theScore];
	[roomView reset];
	for (Item *item in theItems) {
		[roomView addItem:item];
	}	
}


-(void)didNotFetchRoom {
}


@end