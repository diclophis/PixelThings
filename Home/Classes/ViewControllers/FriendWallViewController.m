// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "WallItem.h"
#import "PaginatedWallItems.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"
#import "NSDateAdditions.h"
#import "FriendWallViewController.h"


@implementation FriendWallViewController


@synthesize username;
@synthesize friendUsername;
@synthesize wallItems;
@synthesize tableView;
@synthesize pager;
@synthesize loadMoreButton;
@synthesize activityView;
@synthesize refreshButton;
@synthesize descriptionLabel;
@synthesize inputField;
@synthesize addButton;
@synthesize cancelButton;


-(id)init {
	if ((self = [super initWithNibName:@"FriendWallViewController" bundle:[NSBundle mainBundle]])) {
		NSArray *theWallItems = [[NSArray alloc] init];
		[self setWallItems:theWallItems];
		[theWallItems release];
		
		[[OperationsManager sharedInstance] setWallDelegate:self];
		
		//DESCRIPTION LABEL
		UILabel *theDescriptionLabel = [[UILabel alloc] init];
		[self setDescriptionLabel:theDescriptionLabel];
		[theDescriptionLabel release];
		[descriptionLabel setFrame:CGRectMake(5.0f, 5.0f, 400.0f, 30.0f)];
		[descriptionLabel setText:@""];
		[descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[descriptionLabel setTextColor:[UIColor whiteColor]];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//LOADMORE BUTTON
		[self setLoadMoreButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[loadMoreButton setAdjustsImageWhenHighlighted:YES];
		[loadMoreButton setImage:[UIImage imageNamed:@"ui_forumloadmore.png"] forState:UIControlStateNormal];
		[loadMoreButton setFrame:CGRectMake(5.0, 5.0, 470.0, 30.0)];
		[loadMoreButton addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//ADD BUTTON
		[self setAddButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[addButton setAdjustsImageWhenHighlighted:YES];
		[addButton setImage:[UIImage imageNamed:@"ui_forumadd.png"] forState:UIControlStateNormal];
		[addButton setFrame:CGRectMake(410.0f, 5.0f, 30.0f, 30.0f)];
		[addButton addTarget:self action:@selector(didClickAdd:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//CANCEL BUTTON
		[self setCancelButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[cancelButton setAdjustsImageWhenHighlighted:YES];
		[cancelButton setImage:[UIImage imageNamed:@"ui_forummessageclose.png"] forState:UIControlStateNormal];
		[cancelButton setFrame:CGRectMake(480.0, 70.0, 30.0, 90.0)];
		[cancelButton addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//INPUT FIELD
		UITextView *theInputField = [[UITextView alloc] init];
		[self setInputField:theInputField];
		[theInputField release];
		[inputField setDelegate:self];
		[inputField setFrame:CGRectMake(510.0f, 70.0f, 450.0f, 90.0f)];
		[inputField setBackgroundColor:[UIColor whiteColor]];
		[inputField setReturnKeyType:UIReturnKeyGo];
		[inputField setEnablesReturnKeyAutomatically:YES];
		[inputField setFont:[UIFont systemFontOfSize:14.0f]];
		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
	}
	return self;
}


-(void)dealloc {
	[loadMoreButton release];
	[activityView release];
	[refreshButton release];
	[descriptionLabel release];
	[inputField release];
	[addButton release];
	[cancelButton release];
	[tableView release];
	[pager release];
	[username release];
	[friendUsername release];
	[wallItems release];
	[super dealloc];
}


-(void)viewDidLoad {
	[super viewDidLoad];
	
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:descriptionLabel];
	[[tableView tableHeaderView] addSubview:addButton];
	[[tableView tableHeaderView] addSubview:refreshButton];
	
	UIView *theFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theFooterView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableFooterView:theFooterView];
	[theFooterView release];
	
	[[tableView tableFooterView] addSubview:loadMoreButton];
	[[tableView tableFooterView] addSubview:activityView];
	
	[activityView startAnimating];
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[addButton setHidden:YES];
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchRecentWallItems:friendUsername forPage:1];
}


-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[[self view] addSubview:cancelButton];
	[[self view] addSubview:inputField];
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[tableView setDataSource:nil];
	[tableView setDelegate:nil];
	[inputField resignFirstResponder];
	[[OperationsManager sharedInstance] setWallDelegate:nil];
	[super viewWillDisappear:animated];
}


-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"ReturnToFriend"];
}


-(IBAction)didClickAdd:(id)sender {	
	[inputField setText:@""];
	[inputField becomeFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], -480.0f, 0.0f)];
	[cancelButton setFrame:CGRectOffset([cancelButton frame], -480.0f, 0.0f)];
	[UIView commitAnimations];
}


-(void)didClickCancel:(id)sender {
	[inputField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], 480.0f, 0.0f)];
	[cancelButton setFrame:CGRectOffset([cancelButton frame], 480.0f, 0.0f)];
	[UIView commitAnimations];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if ([text isEqualToString:@"\n"]) {
		[[OperationsManager sharedInstance] saveMessage:[textView text] forWall:friendUsername];
		return NO;
	} else {
		if ([[textView text] length] + [text length] < 140) {
			return YES;
		} else {
			return NO;
		}
	}
}


-(void)didSaveWallMessage {
	[self didClickCancel:nil];
	[self refresh:nil];
	[inputField resignFirstResponder];
}


-(void)didNotSaveWallMessage {
	
}


-(void)didFetchRecentWallItems:(PaginatedWallItems *)thePager {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[addButton setHidden:NO];
	[self setPager:thePager];
	if ([pager currentPage] > 1) {
		[self setWallItems:[wallItems arrayByAddingObjectsFromArray:[pager wallItems]]];
	} else {
		[self setWallItems:[pager wallItems]];
	}
	[[self tableView] reloadData];
	if ([pager totalPages] > [pager currentPage]) {
		[loadMoreButton setHidden:NO];
	}
}


-(void)didNotFetchRecentWallItems {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)loadMore:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[[OperationsManager sharedInstance] fetchRecentWallItems:friendUsername forPage:[pager currentPage] + 1];
}


-(void)refresh:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[self setWallItems:nil];
	[[self tableView] reloadData];
	[[OperationsManager sharedInstance] fetchRecentWallItems:friendUsername forPage:1];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	WallItem *field = [wallItems objectAtIndex:[indexPath row]];
	NSString *formattedMessage = [self messageForWallItem:field];
	CGSize messageSize = [formattedMessage sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(380.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
	
	UILabel *timestamp, *message;
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"wallCell"];
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 40);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"wallCell"] autorelease];
		
		timestamp = [[[UILabel alloc] initWithFrame:CGRectMake(390.0, 5.0, 85.0, 18.0)] autorelease];
		[timestamp setTag:1];
		[timestamp setBackgroundColor:[UIColor clearColor]];
		[timestamp setTextColor:[UIColor whiteColor]];
		//[timestamp setTextAlignment:UITextAlignmentRight];
		[timestamp setAdjustsFontSizeToFitWidth:YES];
		//[timestamp setMinimumFontSize:10.0f];
		[cell.contentView addSubview:timestamp];
		
		message = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 380.0f, 30.0f)] autorelease];
		[message setTag:2];
		[message setBackgroundColor:[UIColor clearColor]];
		[message setTextColor:[UIColor whiteColor]];
		[message setFont:[UIFont systemFontOfSize:14.0f]];
		//[message setLineBreakMode:UILineBreakModeCharacterWrap];
		[message setNumberOfLines:0];
		
		[cell.contentView addSubview:message];
	} else {
		timestamp = (UILabel *)[cell.contentView viewWithTag:1];
		message = (UILabel *)[cell.contentView viewWithTag:2];
	}
	
	[message setFrame:CGRectMake(message.frame.origin.x, message.frame.origin.y, messageSize.width, messageSize.height)];
	[timestamp setText:[[[field createdAt] date] timeAgo]];
	[message setText:formattedMessage];
	
	return cell;
}



-(NSString *)messageForWallItem:(WallItem *)theWallItem {
	NSString *message;
	NSString *you;
	NSString *your;
	if ([[theWallItem friendUsername] isEqualToString:username]) {
		you = @"You";
		your = @"your";
	} else {
		you = [theWallItem friendUsername];
		your = [NSString stringWithFormat:@"%@'s", [theWallItem friendUsername]];
	}
	
	if ([[theWallItem actionType] isEqualToString:@"Liked"]) {
		message = [NSString stringWithFormat:@"%@ liked %@ room", friendUsername, your];
	} else if ([[theWallItem actionType] isEqualToString:@"Like"]) {
		message = [NSString stringWithFormat:@"%@ liked this room", you];
	} else if ([[theWallItem actionType] isEqualToString:@"Visited"]) {
		message = [NSString stringWithFormat:@"%@ visited %@ room", friendUsername, your];
	} else if ([[theWallItem actionType] isEqualToString:@"Visit"]) {
		message = [NSString stringWithFormat:@"%@ visited this room", you];
	} else if ([[theWallItem actionType] isEqualToString:@"Friendship"]) {
		message = [NSString stringWithFormat:@"%@ became friends with %@", you, friendUsername];
	} else if ([[theWallItem actionType] isEqualToString:@"Messaged"]) {
		message = [NSString stringWithFormat:@"%@ wrote \"%@\" on %@ wall", friendUsername, [theWallItem message], your];
	} else if ([[theWallItem actionType] isEqualToString:@"Message"]) {
		message = [NSString stringWithFormat:@"%@ wrote \"%@\"", you, [theWallItem message]];
	} else if ([[theWallItem actionType] isEqualToString:@"Interacted"]) {
		message = [NSString stringWithFormat:@"%@ %@ %@", friendUsername, [theWallItem message], you];
	} else if ([[theWallItem actionType] isEqualToString:@"Interaction"]) {
		message = [NSString stringWithFormat:@"%@ %@ %@", you, [theWallItem message], friendUsername];
	} else {
		message = @"Something cool happened in the world";
	}
	
	return message;
}


-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	WallItem *field = [wallItems objectAtIndex:[indexPath row]]; 
	NSString *message = [self messageForWallItem:field];
	CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(380.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
	return size.height + 10.0f;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [[self wallItems] count];
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
	} else if (buttonIndex == 2) {
		[[OperationsManager sharedInstance] addFriend:[alertView title]];
	}
}


@end