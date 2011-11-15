// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ParseClient.h"
#import "Item.h"
#import "MainViewController.h"
#import "TickerViewController.h"
#import "OperationsManager.h"
#import "RegisterViewController.h"
#import "RoomViewController.h"
#import "MainMenuViewController.h"
#import "DecorateMenuViewController.h"
#import "ItemSelectorViewController.h"
#import "WallViewController.h"
#import "NeighborViewController.h"
#import "StoreViewController.h"
#import "CommunityViewController.h"
#import "NeighborViewController.h"
#import "NeighborMenuViewController.h"
#import "RoomSelectorViewController.h"
#import "ChangeMeViewController.h"
#import "MyStatusViewController.h"
#import "InviteViewController.h"
#import "FriendViewController.h"
#import "FriendsMenuViewController.h"
#import "SimpleExecutingViewController.h"
#import "GamesViewController.h"
#import "FriendWallViewController.h"
#import "Operation.h"
#import "StartViewController.h"
#import "AnimationSystem.h"
#import "Fortunes.h"
#import "AvatarSelectorViewController.h"


@implementation MainViewController


@synthesize tickerView;
@synthesize viewControllers;
@synthesize viewControllersToRelease;
@synthesize defaults;
@synthesize executingView;
@synthesize score;
@synthesize previousAction;
@synthesize forums;
@synthesize chatrooms;
@synthesize firstTime;
@synthesize secondTime;


-(id)initWithCoder:(NSCoder *)theCoder {
	if ((self = [super initWithCoder:theCoder])) {
		[self setViewControllers:[NSMutableDictionary dictionaryWithCapacity:0]];
		[self setViewControllersToRelease:[NSMutableDictionary dictionaryWithCapacity:0]];
		[[OperationsManager sharedInstance] setExecutingDelegate:self];
		[self setPreviousAction:@""];
	}
	return self;
}


-(void)dealloc {
	[defaults release];
	[viewControllers release];
	[viewControllersToRelease release];
	[forums release];
	[executingView release];
	[previousAction release];
	[score release];
	[tickerView release];
	[chatrooms release];
	[super dealloc];
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}


-(void)didReceiveMemoryWarning {
	NSLog(@"MainViewController::didReceiveMemoryWarning");
  [super didReceiveMemoryWarning];
}


-(void)viewDidLoad {
	TickerViewController *theTickerView = [[TickerViewController alloc] init];
	[self setTickerView:theTickerView];
	[theTickerView release];
	[tickerView addObserver:self forKeyPath:@"selectedAction" options:NSKeyValueObservingOptionNew context:nil];
	//[[self view] addSubview:[tickerView view]];
	
	[self setDefaults:[NSUserDefaults standardUserDefaults]];
	NSString *jid = [defaults objectForKey:@"Account.JID"];
	if ([jid length] == 0) {
		[self showController:@"RegisterViewController"];
	} else {
		[[OperationsManager sharedInstance] authenticate];
	}
}


-(void)didReceiveError:(NSString *)message andTerminate:(BOOL)terminate {
	NSLog(@"RETRY!!!!!!!!!!!!!!!!!!!!!!!!!! %@\n", message);
  /*
  if (message) {
    [tickerView enqueueMessage:message withType:nil];
  } else {
    [tickerView enqueueMessage:@"oops" withType:nil];
  }
  */
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if ([[alertView title] isEqualToString:@"What do you want to do?"]) {
		if (buttonIndex == 0) {
			[self performNeighborsMenuAction];
		} else if (buttonIndex == 1) {
			[self performDecorateMenuAction];
		} else if (buttonIndex == 2) {
			[self performStoreMenuAction];
			[[self viewControllerFor:@"StoreViewController"] viewDidAppear:NO];
		}
	}
}


-(void)didBeginExecuting:(Operation *)operation {
	[tickerView enqueueMessage:[operation operationDescription] withType:nil];
	if ([operation indicatesProgress]) {
		if (executingView && [[executingView view] superview]) {
			return;
		} else {
			SimpleExecutingViewController *theExecutingView = [[SimpleExecutingViewController alloc] init];
			[self setExecutingView:theExecutingView];
			[theExecutingView release];
		}
		
		[[self view] addSubview:[executingView view]];
		[[self view] bringSubviewToFront:[executingView view]];
		[[executingView activityView] startAnimating];
	}
}


-(void)didEndExecuting {
	[[executingView view] removeFromSuperview];
}


-(void)setProgress:(NSNumber *)progress andMessage:(NSString *)theMessage {
	[executingView updateProgress:progress];
}


-(void)didRegister {
}


-(void)didNotRegister {
}


-(NSMutableDictionary *)roster {
	return [defaults objectForKey:@"Account.Roster"];
}


-(void)didFetchForums:(NSArray *)theForums andChatrooms:(NSArray *)theChatrooms {
	[self setForums:nil];
	[self setForums:theForums];
	[self setChatrooms:nil];
	[self setChatrooms:theChatrooms];
}


-(void)didUpdateStatus:(NSString *)theStatus {
	[[[AnimationSystem instance] myChar] updateStatus:theStatus];
}


-(void)didFetchRoom:(NSMutableArray *)theItems {
	[self showController:@"RoomSelectorViewController"];
	[[self viewControllerFor:@"RoomSelectorViewController"] activateCurrentPage];
	for (Item *item in theItems) {
		[[[self viewControllerFor:@"RoomSelectorViewController"] activeRoomView] addItem:item];
	}
	[[self viewControllerFor:@"RoomSelectorViewController"] cancelEditMode];
}


-(void)didFetchScore:(Score *)theScore {
	[self setScore:nil];
	[self setScore:theScore];
	[[self viewControllerFor:@"MainMenuViewController"] updateScore:score];
}


-(void)didFetchAvatar:(Avatar *)theAvatar {
	AnimatedPerson *myChar = [AnimatedPerson loadCharacterWithEyebrows:[theAvatar eyebrows]
															   andEyes:[theAvatar eyes]
															  andMouth:[theAvatar mouth]
															   andBody:[theAvatar body]
															   andHair:[theAvatar hair]
															  andShirt:[theAvatar shirt]
															  andPants:[theAvatar pants]
															  intoView:[self view]
															 belowView:[tickerView view]
														   andObserver:self
															 andOrigin:CGPointMake(310, 68)
													 andEnableChangeMe:YES
												   andEnableAnimations:YES
														 andAnimations:[AnimationSystem myMenuActions]];

	[[AnimationSystem instance] setMyChar:myChar];
	[[[AnimationSystem instance] myChar] updateStatus:[theAvatar status]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initiateChangeMe:) name:@"changeAvatar" object:[[AnimationSystem instance] myChar]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didPostNavigate:) name:@"navigate" object:nil];

}


-(void)didPostNavigate:(id)userData {
	[[OperationsManager sharedInstance] saveAvatar:[[[Avatar alloc] initWithStatus:@""
																			 hair:[[[AnimationSystem instance] myChar] hair]
																			shirt:[[[AnimationSystem instance] myChar] shirt]
																			pants:[[[AnimationSystem instance] myChar] pants]
																		 eyebrows:[[[AnimationSystem instance] myChar] eyebrows]
																			 eyes:[[[AnimationSystem instance] myChar] eyes]
																			mouth:[[[AnimationSystem instance] myChar] mouth]
																			 body:[[[AnimationSystem instance] myChar] body]] autorelease]];
	[[self viewControllerFor:@"ChangeMeViewController"] setSelectedAction:@"Main"];
}


-(void)didFetchRoster:(NSMutableDictionary *)theRoster {
	[defaults setObject:theRoster forKey:@"Account.Roster"];
	[defaults synchronize];
}


-(void)didAuthenticate {
	NSDictionary *asplist = [[AnimationSystem instance] plist];
	if (!asplist) {
		NSDictionary *animationSystemPlist = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"AnimationSystem" ofType:@"plist"]];
		[[AnimationSystem instance] setPlist:animationSystemPlist];
	}
	NSDate *lastLoggedInAt = [defaults objectForKey:@"Account.LastLoggedInAt"];
	NSNumber *timesLoggedIn = [defaults objectForKey:@"Account.TimesLoggedIn"];
	if ([timesLoggedIn isKindOfClass:[NSNumber class]]) {
		timesLoggedIn = [NSNumber numberWithInt:[timesLoggedIn intValue] + 1];
	} else {
		timesLoggedIn = [NSNumber numberWithInt:1];
	}
	if ([lastLoggedInAt isKindOfClass:[NSDate class]]) {		
		[self setFirstTime:NO];
		if ([timesLoggedIn intValue] == 2) {
			[self setSecondTime:YES];
		} else {
			[self setSecondTime:NO];
		}
	} else {
		lastLoggedInAt = [NSDate date];
		[self setFirstTime:YES];
		[self setSecondTime:NO];
	}
	[defaults setObject:timesLoggedIn forKey:@"Account.TimesLoggedIn"];
	[defaults setObject:lastLoggedInAt forKey:@"Account.LastLoggedInAt"];
	[defaults synchronize];
	[self hideController:@"RegisterViewController"];
	[[self viewControllerFor:@"MainMenuViewController"] setSelectedAction:@"Main"];
	[[self view] bringSubviewToFront:[[self viewControllerFor:@"MainMenuViewController"] view]];
}


-(void)secondTimePrompt:(NSTimer *)timer {
	UIAlertView *theAlert;
	theAlert = [[UIAlertView alloc] initWithTitle:@"What do you want to do?" message:nil delegate:self cancelButtonTitle:@"Visit Neighbor" otherButtonTitles:@"Decorate Room", @"Shop new items", nil];
	[theAlert show];
	[theAlert autorelease];
}


-(void)didNotAuthenticate {
	[self hideController:@"StartViewController"];
	NSDate *lastLoggedInAt = [defaults objectForKey:@"Account.LastLoggedInAt"];
	if (!lastLoggedInAt) {
		[defaults removeObjectForKey:@"Account.JID"];
		[defaults removeObjectForKey:@"Account.Password"];
		[defaults synchronize];
	}
	[[self viewControllerFor:@"RegisterViewController"] login:self];
	[self showController:@"RegisterViewController"];
}


-(void)willBeginPublishing {
}


-(void)didEndPublishing {
	[[[[AnimationSystem instance] myChar] statusBubble] removeFromSuperview];
	[[[[AnimationSystem instance] myChar] character] removeFromSuperview];
	[[self view] insertSubview:[[[AnimationSystem instance] myChar] character] aboveSubview:[[self viewControllerFor:@"RoomSelectorViewController"] view]];
	[[self view] insertSubview:[[[AnimationSystem instance] myChar] statusBubble] aboveSubview:[[self viewControllerFor:@"RoomSelectorViewController"] view]];
	
	if (firstTime) {
		[self setFirstTime:NO];
		[self performCommunityMenuAction];
		[[self viewControllerFor:@"CommunityViewController"] viewDidAppear:NO];
	} else {
		[self performMainMenuAction];
	}
}


-(id)viewControllerFor:(NSString *)theClassName {
	id viewController = [viewControllers objectForKey:theClassName];
	if (viewController) {
	} else {
		viewController = [[[NSClassFromString(theClassName) alloc] init] autorelease];
		[viewControllers setObject:viewController forKey:theClassName];
		[viewController addObserver:self forKeyPath:@"selectedAction" options:NSKeyValueObservingOptionNew context:nil];
		if ([theClassName isEqualToString:@"ItemSelectorViewController"]) {
			[viewController addObserver:[self viewControllerFor:@"RoomSelectorViewController"] forKeyPath:@"itemToDrop" options:NSKeyValueObservingOptionNew context:nil];
		} else if ([theClassName isEqualToString:@"CommunityViewController"]) {
			[viewController addObserver:self forKeyPath:@"friendsListView.friendToVisit" options:NSKeyValueObservingOptionNew context:nil];
		} else if ([theClassName isEqualToString:@"FriendViewController"]) {
			[viewController addObserver:[self viewControllerFor:@"FriendsMenuViewController"] forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];
		} else if ([theClassName isEqualToString:@"NeighborViewController"]) {
			[viewController addObserver:[self viewControllerFor:@"NeighborMenuViewController"] forKeyPath:@"score" options:NSKeyValueObservingOptionNew context:nil];
		}
	}
	return viewController;
}


-(void)hideController:(NSString *)named {
	id viewController = [viewControllers objectForKey:named];
	if (viewController) {
		[viewControllersToRelease setObject:viewController forKey:named];
		[viewControllers removeObjectForKey:named];
		[viewController viewWillDisappear:YES];
	}
}


-(void)showController:(NSString *)named {
	[self showController:named belowView:[tickerView view]];
}


-(void)showController:(NSString *)named belowView:(UIView *)theView {
	id viewController = [self viewControllerFor:named];
	[[self view] insertSubview:[viewController view] belowSubview:theView];
	[viewController viewWillAppear:YES];
}


-(void)beginMenuTransactions:(NSString *)animationID context:(void *)context {
	for (NSString *viewControllerName in viewControllersToRelease) {
		id viewController = [viewControllersToRelease objectForKey:viewControllerName];
		[viewController removeObserver:self forKeyPath:@"selectedAction"];
		if ([viewControllerName isEqualToString:@"ItemSelectorViewController"]) {
			[viewController removeObserver:[self viewControllerFor:@"RoomSelectorViewController"] forKeyPath:@"itemToDrop"];
		} else if ([viewControllerName isEqualToString:@"CommunityViewController"]) {
			[viewController removeObserver:self forKeyPath:@"friendsListView.friendToVisit"];
		} else if ([viewControllerName isEqualToString:@"FriendViewController"]) {
			[viewController removeObserver:[viewControllersToRelease objectForKey:@"FriendsMenuViewController"] forKeyPath:@"score"];
		} else if ([viewControllerName isEqualToString:@"NeighborViewController"]) {
			[viewController removeObserver:[viewControllersToRelease objectForKey:@"NeighborMenuViewController"] forKeyPath:@"score"];
		}
	}
}


-(void)endMenuTransactions:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	for (NSString *viewControllerName in viewControllersToRelease) {
		id viewController = [viewControllersToRelease objectForKey:viewControllerName];
		[viewController viewDidDisappear:YES];
	}
	[viewControllersToRelease removeAllObjects];
	for (NSString *activeViewControllerKey in viewControllers) {
		id viewController = [viewControllers objectForKey:activeViewControllerKey];
		if ([[viewController view] superview]) {
			[viewController viewDidAppear:YES];
		}
	}
}


-(IBAction)didClickCharacter:(id)sender {

}


-(void)performDefaultMenuAction {
}


-(void)performMainMenuAction {
	[[tickerView view] setHidden:NO];
	[self hideController:@"StartViewController"];
	[self hideController:@"StatsViewController"];
	[self hideController:@"DecorateMenuViewController"];
	[self hideController:@"ItemSelectorViewController"];
	[self hideController:@"StoreViewController"];
	[self hideController:@"CommunityViewController"];
	[self hideController:@"FriendViewController"];
	[self hideController:@"FriendsMenuViewController"];
	[self hideController:@"NeighborViewController"];
	[self hideController:@"NeighborMenuViewController"];
	[self hideController:@"GamesViewController"];
	[self hideController:@"WallViewController"];
	[self hideController:@"ChangeMeViewController"];
	[self hideController:@"MyStatusViewController"];
	[self hideController:@"ChatViewController"];
	[self showController:@"RoomSelectorViewController"];
	[self showController:@"MainMenuViewController"];
	[[self viewControllerFor:@"MainMenuViewController"] updateScore:score];
	[[self viewControllerFor:@"RoomSelectorViewController"] cancelEditMode];
	[[self view] sendSubviewToBack:[[self viewControllerFor:@"RoomSelectorViewController"] view]];
	[[self view] bringSubviewToFront:[[self viewControllerFor:@"MainMenuViewController"] view]];
	[[[[AnimationSystem instance] myChar] character] setUserInteractionEnabled:YES];
	[[[[AnimationSystem instance] myChar] statusBubble] setUserInteractionEnabled:YES];
}


-(void)performDecorateMenuAction {
	[[self viewControllerFor:@"RoomSelectorViewController"] activateCurrentPage];
	[[[[AnimationSystem instance] myChar] character] setUserInteractionEnabled:NO];
	[[[[AnimationSystem instance] myChar] statusBubble] setUserInteractionEnabled:NO];
	[self hideController:@"ItemSelectorViewController"];
	[self hideController:@"MainMenuViewController"];
	[self hideController:@"ChangeMeViewController"];
	[self showController:@"DecorateMenuViewController"];
}


-(void)performBackgroundsMenuAction {
	[self showController:@"ItemSelectorViewController"];
	[[self viewControllerFor:@"ItemSelectorViewController"] loadItems:@"Backgrounds"];
	[self hideController:@"DecorateMenuViewController"];
}


-(void)performFurnitureMenuAction {
	[self showController:@"ItemSelectorViewController"];
	[[self viewControllerFor:@"ItemSelectorViewController"] loadItems:@"Furniture"];
	[self hideController:@"DecorateMenuViewController"];	
}


-(void)performPeopleMenuAction {
	[self showController:@"ItemSelectorViewController"];
	[[self viewControllerFor:@"ItemSelectorViewController"] loadItems:@"People"];
	[self hideController:@"DecorateMenuViewController"];
}


-(void)performAnimalsMenuAction {
	[self showController:@"ItemSelectorViewController"];
	[[self viewControllerFor:@"ItemSelectorViewController"] loadItems:@"Animals"];
	[self hideController:@"DecorateMenuViewController"];	
}


-(void)performMiscMenuAction {
	[self showController:@"ItemSelectorViewController"];
	[[self viewControllerFor:@"ItemSelectorViewController"] loadItems:@"Misc"];
	[self hideController:@"DecorateMenuViewController"];
}


-(void)initiateChangeMe:(id)userData {
	[[self viewControllerFor:@"MainMenuViewController"] setSelectedAction:@"ChangeMe"];
}


-(void)performChangeMeMenuAction {
	[self hideController:@"DecorateMenuViewController"];
	[self hideController:@"MainMenuViewController"];
	[self showController:@"ChangeMeViewController" belowView:[[[AnimationSystem instance] myChar] character]];
}


-(void)performMyStatusMenuAction {
	[self hideController:@"MainMenuViewController"];
	[self showController:@"MyStatusViewController"];
}


-(void)performStoreMenuAction {
	[self hideController:@"MainMenuViewController"];
	[self showController:@"StoreViewController"];
}

-(void)performCloseChangeMeMenuAction {
	[self hideController:@"ChangeMeViewController"];
}


-(void)performInviteMenuAction {
	[[tickerView view] setHidden:YES];
	[self showController:@"InviteViewController"];
	[self hideController:@"CommunityViewController"];
}


-(void)performStatsMenuAction {
	[self hideController:@"MainMenuViewController"];
	[self showController:@"StatsViewController"];
}


-(void)performCommunityMenuAction {
	[[tickerView view] setHidden:NO];
	[self hideController:@"ItemSelectorViewController"];
	[self hideController:@"MainMenuViewController"];
	[self hideController:@"FriendViewController"];
	[self hideController:@"FriendsMenuViewController"];
	[self hideController:@"InviteViewController"];
	[self hideController:@"NeighborViewController"];
	[self hideController:@"NeighborMenuViewController"];
	[self hideController:@"DecorateMenuViewController"];
	[self hideController:@"ChatViewController"];
	[[self viewControllerFor:@"CommunityViewController"] setForums:forums];
	[[self viewControllerFor:@"CommunityViewController"] setChatrooms:chatrooms];
	[self showController:@"CommunityViewController"];
}


-(void)performChatMenuAction {
	[[tickerView view] setHidden:YES];
	[self hideController:@"ItemSelectorViewController"];
	[self hideController:@"MainMenuViewController"];
	[self hideController:@"FriendViewController"];
	[self hideController:@"FriendsMenuViewController"];
	[self hideController:@"InviteViewController"];
	[self hideController:@"NeighborViewController"];
	[self hideController:@"NeighborMenuViewController"];
	[self hideController:@"DecorateMenuViewController"];
	[self hideController:@"CommunityViewController"];
	[self showController:@"ChatViewController"];
}


-(void)performNeighborsMenuAction {
	[self hideController:@"DecorateViewController"];
	[self hideController:@"CommunityViewController"];
	[self hideController:@"MainMenuViewController"];
	[self showController:@"NeighborViewController"];
	[self showController:@"NeighborMenuViewController"];
}


-(void)performGamesMenuAction {
	[[tickerView view] setHidden:NO];
	[self hideController:@"SuperRewardsNavigationController"];
	[self hideController:@"MainMenuViewController"];
	[self showController:@"GamesViewController"];
}


-(void)performSuperRewardsMenuAction {
	[[tickerView view] setHidden:YES];
	[self hideController:@"GamesViewController"];
	[[[self view] window] addSubview:[[self viewControllerFor:@"SuperRewardsNavigationController"] view]];
}


-(void)performPublishRoomMenuAction {
	[[[[AnimationSystem instance] myChar] statusBubble] removeFromSuperview];
	[[[[AnimationSystem instance] myChar] character] removeFromSuperview];
	[[[self viewControllerFor:@"RoomSelectorViewController"] view] addSubview:[[[AnimationSystem instance] myChar] character]];
	[[[self viewControllerFor:@"RoomSelectorViewController"] view] addSubview:[[[AnimationSystem instance] myChar] statusBubble]];
	[[OperationsManager sharedInstance] saveRoom:[[[self viewControllerFor:@"RoomSelectorViewController"] activeRoomView] items] andLayer:[[self viewControllerFor:@"RoomSelectorViewController"] view].layer];
}


-(void)performSaveToPhotoAlbumMenuAction {
	[self hideController:@"ItemSelectorViewController"];
	[[tickerView view] setHidden:YES];
	[[OperationsManager sharedInstance] saveToPhotoAlbum:[[self viewControllerFor:@"RoomSelectorViewController"] view].layer];	
}


-(void)performWallMenuAction {
	[[self viewControllerFor:@"WallViewController"] setUsername:[score username]];
	[self hideController:@"MainMenuViewController"];
	[self showController:@"WallViewController"];
}


-(void)performFriendWallMenuAction {
	[[self viewControllerFor:@"FriendWallViewController"] setUsername:[score username]];
	[[self viewControllerFor:@"FriendWallViewController"] setFriendUsername:[[self viewControllerFor:@"FriendViewController"] username]];
	[self showController:@"FriendWallViewController"];
}


-(void)performFriendStatsMenuAction {
	[[self viewControllerFor:@"FriendStatsViewController"] setFriendUsername:[[self viewControllerFor:@"FriendViewController"] username]];
	[self showController:@"FriendStatsViewController"];
}


-(void)performReturnToFriendMenuAction {
	[self hideController:@"FriendStatsViewController"];
	[self hideController:@"FriendWallViewController"];
}


-(void)performNeighborStatsMenuAction {
	[[self viewControllerFor:@"NeighborStatsViewController"] setFriendUsername:[[[self viewControllerFor:@"NeighborViewController"] score] username]];
	[self showController:@"NeighborStatsViewController"];
}


-(void)performReturnToNeighborMenuAction {
	[self hideController:@"NeighborStatsViewController"];
}


-(void)performInfoMenuAction {
	[self showController:@"InfoViewController"];
	[[self view] bringSubviewToFront:[[self viewControllerFor:@"InfoViewController"] view]];
}


-(void)performOpenForumRulesMenuAction {
	[self showController:@"ForumRulesViewController"];
	[[self view] bringSubviewToFront:[[self viewControllerFor:@"ForumRulesViewController"] view]];
}


-(void)performCloseForumRulesMenuAction {
	[self hideController:@"ForumRulesViewController"];
}


-(void)performCloseInfoMenuAction {
	[self hideController:@"InfoViewController"];
}


-(void)performDoCharacterAnimationMenuAction {
	[[OperationsManager sharedInstance] doCharacterAnimationOperation];
}


-(void)changeYourAvatarPrompt:(NSTimer *)timer {
	UIAlertView *theAlert;
	theAlert = [[UIAlertView alloc] initWithTitle:@"Change your avatar" message:@"You can always change by clicking your avatar" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[theAlert show];
	[theAlert autorelease];
}


-(void)decorateYourRoomPrompt:(NSTimer *)timer {
	UIAlertView *theAlert;
	theAlert = [[UIAlertView alloc] initWithTitle:@"Decorate your room" message:@"Decorate your room with free items" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];	
	[theAlert show];
	[theAlert autorelease];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"selectedAction"]) {
		NSString *selectedAction = [object selectedAction];
		if (firstTime) {
			if ([previousAction isEqualToString:@""]) {
				selectedAction = @"ChangeMe";
			} else if ([previousAction isEqualToString:@"ChangeMe"]) {
				selectedAction = @"Decorate";
			} else if ([previousAction isEqualToString:@"Decorate"] && ([selectedAction isEqualToString:@"Main"] || [selectedAction isEqualToString:@"PublishRoom"])) {
				selectedAction = @"PublishRoom";
			}
		}
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[UIView setAnimationDelegate:self];
		SEL changeMenuSelector = NSSelectorFromString([NSString stringWithFormat:@"perform%@MenuAction", selectedAction]);
		[self performSelector:changeMenuSelector];
		[UIView setAnimationWillStartSelector:@selector(beginMenuTransactions:context:)];
		[UIView setAnimationDidStopSelector:@selector(endMenuTransactions:finished:context:)];
		[UIView commitAnimations];
		NSString *selectorString = [NSString stringWithFormat:@"performFrom%@To%@Action", previousAction, selectedAction];
		SEL actionSelector = NSSelectorFromString(selectorString);
		if ([self respondsToSelector:actionSelector]) {
			[self performSelector:actionSelector];
		}
		[self setPreviousAction:selectedAction];
	} else if ([keyPath isEqualToString:@"friendsListView.friendToVisit"] || [keyPath isEqualToString:@"friendToVisit"]) {
		[[self viewControllerFor:@"FriendsMenuViewController"] setFromKeyPath:keyPath];
		[[self viewControllerFor:@"FriendViewController"] setUsername:[change objectForKey:@"new"]];
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationWillStartSelector:@selector(beginMenuTransactions:context:)];		
		[UIView setAnimationDidStopSelector:@selector(endMenuTransactions:finished:context:)];
		[self hideController:@"CommunityViewController"];
		[self showController:@"FriendViewController" belowView:[[[AnimationSystem instance] myChar] character]];
		[[[AnimationSystem instance] myChar] setHidden:YES];
		[self showController:@"FriendsMenuViewController"];
		[self setPreviousAction:@"ViewFriend"];
		[UIView commitAnimations];
	}
}

@end