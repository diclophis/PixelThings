// GPL


#import "FriendViewController.h"
#import "OperationsManager.h"
#import "Item.h"
#import "RoomViewController.h"
#import "AnimatedPerson.h"
#import "AnimationSystem.h"


@implementation FriendViewController


@synthesize scrollView;
@synthesize username;
@synthesize score;
@synthesize roomView;


-(id)init {
	if ((self = [super initWithNibName:@"FriendViewController" bundle:[NSBundle mainBundle]])) {
		RoomViewController *theRoomView = [[RoomViewController alloc] init];
		[self setRoomView:theRoomView];
		[theRoomView release];
	}
	return self;
}


-(void)dealloc {
	[username release];
	[score release];
	[scrollView release];
	[roomView release];
	[super dealloc];
}


-(void)viewDidLoad {
	[[self view] setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 0.0f)];
	[scrollView setScrollEnabled:NO];
	[scrollView setContentSize:CGSizeMake(480.0f * 2, 320.0f)];
	[scrollView addSubview:[roomView view]];
}


-(void)viewWillAppear:(BOOL)animated {
	[[OperationsManager sharedInstance] setAvatarViewingDelegate:self];
	[[OperationsManager sharedInstance] fetchFriendsRoom:username];
	[super viewWillAppear:animated];
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[[OperationsManager sharedInstance] setAvatarViewingDelegate:nil];
	[[self view] setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 320.0f)];
	[[[AnimationSystem instance] neighbor] release];
	[[AnimationSystem instance] setNeighbor:nil];
	[[[AnimationSystem instance] myChar] setHidden:NO];
}


-(void)didFetchRoom:(NSMutableArray *)theItems andScore:(Score *)theScore andAvatar:(Avatar *)theAvatar {
	[self setScore:theScore];
	
	
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
															 andOrigin:CGPointMake(310, 68)
													 andEnableChangeMe:NO
												   andEnableAnimations:YES
														 andAnimations:[AnimationSystem neighborMenuActions]];
	[neighbor setSingleClickAction:@"showAnimationMenu"];
	[[AnimationSystem instance] setNeighbor:neighbor];
	[[[AnimationSystem instance] neighbor] updateStatus:[theAvatar status]];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPostInteractWithFriend:) name:@"interactWithFriend" object:nil];

	for (Item *item in theItems) {
		[roomView addItem:item];
	}
}


-(void)didPostInteractWithFriend:(id)userData {
	[[OperationsManager sharedInstance] interactWithFriend:[score username] andInteraction:[[userData userInfo] objectForKey:@"interaction"]];
}



-(void)didNotFetchRoom {
}


@end