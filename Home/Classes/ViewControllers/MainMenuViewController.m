// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Score.h"
#import "StoreViewController.h"
#import "CommunityViewController.h"
#import "WallViewController.h"
#import "MainMenuViewController.h"



@implementation MainMenuViewController


@synthesize score;
@synthesize wallItemsBackground;
@synthesize wallItemsButton;


-(id)init {
	if ((self = [super initWithNibName:@"MainMenuViewController" bundle:[NSBundle mainBundle]])) {
		[self setWallItemsBackground:[[UIImage imageNamed:@"ui_wallitems.png"] stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0]];
		[self setWallItemsButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[wallItemsButton addTarget:self action:@selector(didClickWall:) forControlEvents:UIControlEventTouchUpInside];
		[wallItemsButton setFrame:CGRectMake(135.0f,33.0f, 30.0f, 22.0f)];
		[wallItemsButton setBackgroundImage:wallItemsBackground forState:UIControlStateNormal];
	}
	return self;
}


-(void)dealloc {
	[wallItemsButton release];
	[wallItemsBackground release];
	[score release];
	[super dealloc];
}


-(void)viewDidLoad {
	[[self view] addSubview:wallItemsButton];
	[wallItemsButton setHidden:YES];
	[super viewDidLoad];
}


-(IBAction)didClickHome:(id)sender {
	[self toggle];
}


-(IBAction)didClickDecorate:(id)sender {
	[self setSelectedAction:@"Decorate"];
}


-(IBAction)didClickMe:(id)sender {
	[self setSelectedAction:@"Me"];
}


-(IBAction)didClickStore:(id)sender {
	[self setSelectedAction:@"Store"];
}


-(IBAction)didClickCommunity:(id)sender {
	[self setSelectedAction:@"Community"];
}


-(IBAction)didClickGame:(id)sender {
	[self setSelectedAction:@"Games"];
}


-(IBAction)didClickWall:(id)sender {
	[self setSelectedAction:@"Wall"];
}


-(IBAction)didClickStats:(id)sender {
	[self setSelectedAction:@"Stats"];
}


-(void)updateScore:(Score *)theScore {
	[self setScore:nil];
	[self setScore:theScore];
	[usernameLabel setText:[score username]];
	[likesLabel setText:[NSString stringWithFormat:@"%d", [score likes]]];
	[visitsLabel setText:[NSString stringWithFormat:@"%d", [score visits]]];
	[pointsLabel setText:[NSString stringWithFormat:@"%d", [score points]]];
	[friendsLabel setText:[NSString stringWithFormat:@"%d", [score friends]]];
	[self updateNewWallItemsCount];
}


-(void)updateNewWallItemsCount {
	if ([score newWallItems] > 0) {
		[wallItemsButton setTitle:[NSString stringWithFormat:@"%d", [score newWallItems]] forState:UIControlStateNormal];
		[wallItemsButton setHidden:NO];
	} else {
		[wallItemsButton setHidden:YES];
	}
}


@end
