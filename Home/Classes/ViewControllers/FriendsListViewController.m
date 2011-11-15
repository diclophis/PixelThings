#import "FriendsListViewController.h"
#import "OperationsManager.h"


@implementation FriendsListViewController


@synthesize roster;
@synthesize friendToVisit;
@synthesize backButton;
@synthesize titleLabel;
@synthesize isDismissed;


-(id)init {
	if ((self = [super initWithNibName:@"FriendsListViewController" bundle:[NSBundle mainBundle]])) {
		[self setRoster:[NSMutableDictionary dictionaryWithDictionary:[[[OperationsManager sharedInstance] executingDelegate] roster]]];
		
		//BACK BUTTON
		[self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[backButton setAdjustsImageWhenHighlighted:YES];
		[backButton setImage:[UIImage imageNamed:@"ui_forumback.png"] forState:UIControlStateNormal];
		[backButton setFrame:CGRectMake(5.0f, 5.0f, 30.0f, 30.0f)];
		[backButton setTitle:@"B" forState:UIControlStateNormal];
		[backButton addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
		
		//TITLE
		UILabel *theTitleLabel = [[UILabel alloc] init];
		[self setTitleLabel:theTitleLabel];
		[theTitleLabel release];
		[titleLabel setFrame:CGRectMake(40.0f, 5.0f, 360.0f, 30.0f)];
		//TODO
		//[titleLabel setText:@"Your friends"];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor blackColor]];
		
	}
	return self;
}


-(void)dealloc {
	[titleLabel release];
	[backButton release];
	[roster release];
	[friendToVisit release];
	[super dealloc];
}


-(void)viewDidLoad {
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:backButton];
	[[tableView tableHeaderView] addSubview:titleLabel];
}


-(NSInteger)onlineFriends {
	NSInteger i=0;
	for (NSString *userKey in roster) {
		NSMutableDictionary *userDictionary = [roster objectForKey:userKey];
		if ([[userDictionary objectForKey:@"online"] isEqualToString:@"1"]) {
			i++;
		}
	}
	
	return i;
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"friendsListViewCell"];
	UILabel *nickname, *status;
	UIImageView *icon;
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 50);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"friendsListViewCell"] autorelease];
		
		icon = [[[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 12.0f, 30.0f, 26.0f)] autorelease];
		icon.tag = 1;
		[cell.contentView addSubview:icon];
		
		nickname = [[[UILabel alloc] initWithFrame:CGRectMake(35.0, 5.0, 200.0, 40.0)] autorelease];
		[nickname setBackgroundColor:[UIColor clearColor]];
		nickname.tag = 2;
		nickname.font = [UIFont boldSystemFontOfSize:14.0];
		nickname.textAlignment = UITextAlignmentLeft;
		nickname.textColor = [UIColor whiteColor];
		[cell.contentView addSubview:nickname];
		
		status = [[[UILabel alloc] initWithFrame:CGRectMake(240.0, 5.0, 235.0, 40.0)] autorelease];
		[status setBackgroundColor:[UIColor clearColor]];
		status.tag = 3;
		status.font = [UIFont systemFontOfSize:13.0];
		status.textAlignment = UITextAlignmentRight;
		status.textColor = [UIColor whiteColor];
		
		[cell.contentView addSubview:status];
	} else {
		icon = (UIImageView *)[cell.contentView viewWithTag:1];
		nickname = (UILabel *)[cell.contentView viewWithTag:2];
		status = (UILabel *)[cell.contentView viewWithTag:3];
	}
	
	
	NSArray *rosterKeys = [roster allKeys];
	NSString *thisKey = [rosterKeys objectAtIndex:[indexPath row]];
	NSMutableDictionary *userDictionary = [roster objectForKey:thisKey];
	[nickname setText:thisKey];
	[status setText:[userDictionary objectForKey:@"status"]];
	UIImage *theImage;
	if ([[userDictionary objectForKey:@"online"] isEqualToString:@"1"]) {
		theImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ui_useronline" ofType:@"png"]];
	} else {
		theImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ui_useroffline" ofType:@"png"]];
	}
	[icon setImage:theImage];

	return cell;
}

-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [roster count];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *rosterKeys = [roster allKeys];
	[self setFriendToVisit:[rosterKeys objectAtIndex:[indexPath row]]];
}


-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
}


-(void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray *rosterKeys = [roster allKeys];
	[[OperationsManager sharedInstance] removeFriend:[rosterKeys objectAtIndex:[indexPath row]]];
	[roster removeObjectForKey:[rosterKeys objectAtIndex:[indexPath row]]];
	[aTableView reloadData];
}


-(IBAction)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


@end