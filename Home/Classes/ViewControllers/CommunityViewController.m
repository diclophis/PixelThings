// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Forum.h"
#import "CommunityViewController.h"
#import "NeighborViewController.h"
#import "AddFriendViewController.h"
#import "InviteViewController.h"
#import "FriendsListViewController.h"
#import "TopicsViewController.h"


@implementation CommunityViewController


@synthesize friendsListView;
@synthesize addFriendView;
@synthesize forums;
@synthesize chatrooms;
@synthesize topicsView;


-(id)init {
	if ((self = [super initWithNibName:@"CommunityViewController" bundle:[NSBundle mainBundle]])) {
		[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
		FriendsListViewController *theFriendsListView = [[FriendsListViewController alloc] init];
		[self setFriendsListView:theFriendsListView];
		[theFriendsListView release];
		[friendsListView addObserver:self forKeyPath:@"isDismissed" options:NSKeyValueObservingOptionNew context:nil];
	}
	return self;
}


-(void)dealloc {
	[friendsListView release];
	[addFriendView release];
	[topicsView release];
	[forums release];
	[chatrooms release];
	[super dealloc];
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	if ([forums count] > 0) {
		[forumsLabel setText:[NSString stringWithFormat:@"%d/%d", [[forums objectAtIndex:0] topicsCount], [[forums objectAtIndex:0] postsCount]]];
	}
	
	if ([chatrooms count] > 0) {
		[chatroomsLabel setText:[NSString stringWithFormat:@"%d", [[chatrooms objectAtIndex:0] count]]];
	}
	
	[friendsLabel setText:[NSString stringWithFormat:@"%d", [friendsListView onlineFriends]]];
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	if (friendsListView) {
		[friendsListView removeObserver:self forKeyPath:@"isDismissed"];
	}
	if (addFriendView) {
		[addFriendView removeObserver:self forKeyPath:@"isDismissed"];
	}
	[addFriendView viewWillDisappear:animated];
	if (topicsView) {
		[topicsView removeObserver:self forKeyPath:@"isDismissed"];
		[topicsView removeObserver:self forKeyPath:@"viewForumRules"];
		[topicsView viewWillDisappear:animated];
	}
}


-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"Main"];
}


-(void)didStopDismissing:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	if ([animationID isEqualToString:@"TopicsViewController"]) {
		[topicsView removeObserver:self forKeyPath:@"isDismissed"];
		[topicsView removeObserver:self forKeyPath:@"viewForumRules"];
		[self setTopicsView:nil];
	}
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"isDismissed"]) {
		if ([object isKindOfClass:[AddFriendViewController class]]) {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDuration:ANIMATION_DURATION];
			[addFriendView viewWillDisappear:YES];
			[[addFriendView view] setFrame:CGRectOffset([[addFriendView view] frame], 480.0f, 0.0f)];
			[tableView setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
			[UIView commitAnimations];
		} else if ([object isKindOfClass:[TopicsViewController class]]) {
			[UIView beginAnimations:@"TopicsViewController" context:NULL];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDidStopSelector:@selector(didStopDismissing:finished:context:)];
			[UIView setAnimationDuration:ANIMATION_DURATION];
			[topicsView viewWillDisappear:YES];
			[[topicsView view] setFrame:CGRectOffset([[topicsView view] frame], 480.0f, 0.0f)];
			[tableView setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
			[UIView commitAnimations];
		} else if ([object isKindOfClass:[FriendsListViewController class]]) {
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDuration:ANIMATION_DURATION];
			[friendsListView viewWillDisappear:YES];
			[[friendsListView view] setFrame:CGRectOffset([[friendsListView view] frame], 480.0f, 0.0f)];
			[tableView setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
			[UIView commitAnimations];
		}
	} else if ([keyPath isEqualToString:@"viewForumRules"]) {
		[self setSelectedAction:@"OpenForumRules"];
	}
}


-(IBAction)didClickFriends:(id)sender {
	[[self view] addSubview:[friendsListView view]];
	[[friendsListView view] setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	
	[[friendsListView view] setFrame:[tableView frame]];
	[tableView setFrame:CGRectOffset([tableView frame], -480.0f, 0.0f)];
	
	[UIView commitAnimations];
}


-(IBAction)didClickInvite:(id)sender {
	[self setSelectedAction:@"Invite"];

}


-(IBAction)didClickNeighbors:(id)sender {
	[self setSelectedAction:@"Neighbors"];

}


-(IBAction)didClickAddFriend:(id)sender {
	if (addFriendView) {
		[addFriendView removeObserver:self forKeyPath:@"isDismissed"];
	}
	AddFriendViewController *theAddFriendView = [[AddFriendViewController alloc] init];
	[self setAddFriendView:theAddFriendView];
	[theAddFriendView release];
	[addFriendView addObserver:self forKeyPath:@"isDismissed" options:NSKeyValueObservingOptionNew context:nil];
	
	[[self view] addSubview:[addFriendView view]];
	[[addFriendView view] setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	
	[[addFriendView view] setFrame:[tableView frame]];
	[tableView setFrame:CGRectOffset([tableView frame], -480.0f, 0.0f)];
	
	[UIView commitAnimations];
}


-(IBAction)didClickForum:(id)sender {

	topicsView = [[TopicsViewController alloc] initWithForum:[forums objectAtIndex:0]];
	[topicsView addObserver:self forKeyPath:@"isDismissed" options:NSKeyValueObservingOptionNew context:nil];
	[topicsView addObserver:self forKeyPath:@"viewForumRules" options:NSKeyValueObservingOptionNew context:nil];
	
	[topicsView viewWillAppear:YES];
	[[self view] addSubview:[topicsView view]];
	[[topicsView view] setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[[topicsView view] setFrame:[tableView frame]];
	[tableView setFrame:CGRectOffset([tableView frame], -480.0f, 0.0f)];
	[UIView commitAnimations];
	
}


-(IBAction)didClickChat:(id)sender {
	[self setSelectedAction:@"Chat"];
}


-(IBAction)didClickFacebook:(id)sender {

}


@end