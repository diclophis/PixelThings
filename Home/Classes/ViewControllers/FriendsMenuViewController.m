// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Score.h"
#import "OperationsManager.h"
#import "FriendsMenuViewController.h"


@implementation FriendsMenuViewController


@synthesize fromKeyPath;


-(id)init {
	if ((self = [super initWithNibName:@"FriendsMenuViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)dealloc {
	[fromKeyPath release];
	[super dealloc];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(480.0f, 240.0f, 480.0f, 80.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[likeButton setEnabled:NO];
	[wallButton setEnabled:NO];
	[statsButton setEnabled:NO];
	[likesLabel setHidden:YES];
	[friendsLabel setHidden:YES];
	[visitsLabel setHidden:YES];
	[usernameLabel setHidden:YES];
	
	[self setExpanded:YES];
	[[self view] setFrame:CGRectMake(0.0f, 240.0f, 480.0f, 80.0f)];
}


-(IBAction)didClickBack:(id)sender {
	if ([fromKeyPath isEqualToString:@"friendsListView.friendToVisit"]) {
		[self setSelectedAction:@"Community"];
	} else if ([fromKeyPath isEqualToString:@"friendToVisit"]) {
		[self setSelectedAction:@"ReturnToChat"];
	}
}


-(IBAction)didClickLike:(id)sender {
	[[OperationsManager sharedInstance] likeRoom:[usernameLabel text]];
	[likesLabel setText:[NSString stringWithFormat:@"%i", [[likesLabel text] intValue] + 1]];
	[sender setEnabled:NO];
}


-(IBAction)didClickStats:(id)sender {
	[self setSelectedAction:@"FriendStats"];
}


-(IBAction)didClickWall:(id)sender {
	[self setSelectedAction:@"FriendWall"];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"score"]) {
    Score *score = [change objectForKey:@"new"];
		[likeButton setEnabled:YES];
		[statsButton setEnabled:YES];
		[wallButton setEnabled:YES];
		[likesLabel setHidden:NO];
		[visitsLabel setHidden:NO];
		[usernameLabel setHidden:NO];
		[friendsLabel setHidden:NO];
		[usernameLabel setText:[score username]];
		[friendsLabel setText:[NSString stringWithFormat:@"%d", [score friends]]];
		[visitsLabel setText:[NSString stringWithFormat:@"%d", [score visits]]];
		[likesLabel setText:[NSString stringWithFormat:@"%d", [score likes]]];
		[pointsLabel setText:[NSString stringWithFormat:@"%d", [score points]]];
	}
}


@end