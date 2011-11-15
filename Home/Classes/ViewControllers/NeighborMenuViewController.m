// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Score.h"
#import "NeighborMenuViewController.h"
#import "OperationsManager.h"


@implementation NeighborMenuViewController


-(id)init {
	if ((self = [super initWithNibName:@"NeighborMenuViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)dealloc {
	[super dealloc];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(480.0f, 240.0f, 480.0f, 80.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[addButton setEnabled:NO];
	[likeButton setEnabled:NO];
	[randomButton setEnabled:NO];
	[statsButton setEnabled:NO];
	[self setExpanded:YES];
	[likesLabel setHidden:YES];
	[visitsLabel setHidden:YES];
	[usernameLabel setHidden:YES];
	[visitsTitleLabel setHidden:YES];
	[likesTitleLabel setHidden:YES];
	[friendsLabel setHidden:YES];
	[friendsTitleLabel setHidden:YES];
	[pointsLabel setHidden:YES];
	[pointsTitleLabel setHidden:YES];
	[[self view] setFrame:CGRectMake(0.0f, 240.0f, 480.0f, 80.0f)];
}


-(IBAction)didClickBack:(id)sender {
	[self setSelectedAction:@"Community"];
}


-(IBAction)didClickLike:(id)sender {
	[[OperationsManager sharedInstance] likeRoom:[usernameLabel text]];
	[likesLabel setText:[NSString stringWithFormat:@"%i", [[likesLabel text] intValue] + 1]];
	[sender setEnabled:NO];
}


-(IBAction)didClickAdd:(id)sender {
	[[OperationsManager sharedInstance] addFriend:[usernameLabel text]];
}


-(IBAction)didClickRandom:(id)sender {
	[[OperationsManager sharedInstance] fetchRandomFriendsRoom];
}


-(IBAction)didClickStats:(id)sender {
	[self setSelectedAction:@"NeighborStats"];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	[addButton setEnabled:YES];
	[likeButton setEnabled:YES];
	[randomButton setEnabled:YES];
	[statsButton setEnabled:YES];
	[likesLabel setHidden:NO];
	[visitsLabel setHidden:NO];
	[usernameLabel setHidden:NO];
	[visitsTitleLabel setHidden:NO];
	[likesTitleLabel setHidden:NO];
	[friendsLabel setHidden:NO];
	[friendsTitleLabel setHidden:NO];
	[pointsLabel setHidden:NO];
	[pointsTitleLabel setHidden:NO];
	if ([keyPath isEqualToString:@"score"]) {
		Score *score = [change objectForKey:@"new"];
		[usernameLabel setText:[score username]];
		[friendsLabel setText:[NSString stringWithFormat:@"%d", [score friends]]];
		[visitsLabel setText:[NSString stringWithFormat:@"%d", [score visits]]];
		[likesLabel setText:[NSString stringWithFormat:@"%d", [score likes]]];
		[pointsLabel setText:[NSString stringWithFormat:@"%d", [score points]]];
	}
}


@end
