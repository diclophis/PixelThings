// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "WallItem.h"
#import "PaginatedWallItems.h"
#import "OperationsManager.h"
#import "NSDateAdditions.h"
#import "NSStringAdditions.h"
#import "WallViewController.h"


@implementation WallViewController


@synthesize username;
@synthesize friendUsername;
@synthesize wallItems;
@synthesize tableView;
@synthesize pager;
@synthesize loadMoreButton;
@synthesize activityView;
@synthesize refreshButton;
@synthesize descriptionLabel;


-(id)init {
	if ((self = [super initWithNibName:@"WallViewController" bundle:[NSBundle mainBundle]])) {
		[self setWallItems:nil];
		
		[[OperationsManager sharedInstance] setWallDelegate:self];

		//DESCRIPTION LABEL
		UILabel *theDescriptionLabel = [[UILabel alloc] init];
		[self setDescriptionLabel:theDescriptionLabel];
		[theDescriptionLabel release];
		[descriptionLabel setFrame:CGRectMake(5.0f, 5.0f, 470.0f, 30.0f)];
		//TODO
		[descriptionLabel setText:@""];
		[descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[descriptionLabel setTextColor:[UIColor whiteColor]];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton setTitle:@"R" forState:UIControlStateNormal];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//LOADMORE BUTTON
		[self setLoadMoreButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[loadMoreButton setAdjustsImageWhenHighlighted:YES];
		[loadMoreButton setImage:[UIImage imageNamed:@"ui_forumloadmore.png"] forState:UIControlStateNormal];
		[loadMoreButton setFrame:CGRectMake(5.0, 5.0, 470.0, 30.0)];
		[loadMoreButton setTitle:@"Load More..." forState:UIControlStateNormal];
		[loadMoreButton addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
	}
	return self;
}


-(void)dealloc {
	[myAdViewController release];
	[loadMoreButton release];
	[activityView release];
	[refreshButton release];
	[descriptionLabel release];
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
	[[self view] setUserInteractionEnabled:NO];
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchRecentWallItems:username forPage:1];
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[[OperationsManager sharedInstance] setWallDelegate:nil];
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	[myAdViewController viewWillDisappear:animated];
}


-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"Main"];
}


-(void)didFetchRecentWallItems:(PaginatedWallItems *)thePager {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[self setPager:nil];
	[self setPager:thePager];
	if ([pager currentPage] > 1) {
		[self setWallItems:[wallItems arrayByAddingObjectsFromArray:[pager wallItems]]];
	} else {
		[self setWallItems:[pager wallItems]];
	}
	[tableView reloadData];
	if ([pager totalPages] > [pager currentPage]) {
		[loadMoreButton setHidden:NO];
	}
	[[self view] setUserInteractionEnabled:YES];
}


-(void)didNotFetchRecentWallItems {
	[[self view] setUserInteractionEnabled:YES];

	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)didSaveWallMessage {
}


-(void)didNotSaveWallMessage {
}


-(void)loadMore:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[[OperationsManager sharedInstance] fetchRecentWallItems:username forPage:[pager currentPage] + 1];
}


-(void)refresh:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[self setWallItems:nil];
	[tableView reloadData];
	[[OperationsManager sharedInstance] fetchRecentWallItems:username forPage:1];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	WallItem *field = [wallItems objectAtIndex:[indexPath row]];
	UILabel *timestamp, *message;
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"wallCell"];
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 40);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"wallCell"] autorelease];
		
		
		timestamp = [[[UILabel alloc] initWithFrame:CGRectMake(390.0, 5.0, 85.0, 30.0)] autorelease];
		[timestamp setBackgroundColor:[UIColor clearColor]];
		[timestamp setTag:1];
		[timestamp setFont:[UIFont systemFontOfSize:12.0]];
		[timestamp setTextColor:[UIColor whiteColor]];
		//[timestamp setTextAlignment:UITextAlignmentRight];
		//[timestamp setMinimumFontSize:10.0f];
		[timestamp setAdjustsFontSizeToFitWidth:YES];
		[cell.contentView addSubview:timestamp];
		

		message = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 380.0f, 30.0f)] autorelease];
		[message setTag:2];
		[message setNumberOfLines:0];
		//[message setLineBreakMode:UILineBreakModeWordWrap];
		[message setFont:[UIFont systemFontOfSize:14.0f]];
		[message setBackgroundColor:[UIColor clearColor]];
		[message setTextColor:[UIColor whiteColor]];
		
		[cell.contentView addSubview:message];
	} else {
		timestamp = (UILabel *)[cell.contentView viewWithTag:1];
		message = (UILabel *)[cell.contentView viewWithTag:2];
	}
	
	CGSize size = [[self messageForWallItem:field] sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(380.0f, CGFLOAT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
	[message setFrame:CGRectMake(5.0, 5.0, size.width, size.height)];
	[timestamp setText:[[[field createdAt] date] timeAgo]];
	[message setText:[self messageForWallItem:field]];

	return cell;
}


-(NSString *)messageForWallItem:(WallItem *)theWallItem {
	
	NSString *message;
	
	if ([[theWallItem actionType] isEqualToString:@"Liked"]) {
		message = [NSString stringWithFormat:@"You liked %@'s room", [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Like"]) {
		message = [NSString stringWithFormat:@"%@ liked your room", [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Visited"]) {
		message = [NSString stringWithFormat:@"You visited %@'s room", [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Visit"]) {
		message = [NSString stringWithFormat:@"%@ visited your room", [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Friendship"]) {
		message = [NSString stringWithFormat:@"You became friends with %@", [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Registered"]) {
		message = [NSString stringWithFormat:@"Welcome to Home!"];
	} else if ([[theWallItem actionType] isEqualToString:@"Messaged"]) {
		message = [NSString stringWithFormat:@"You wrote \"%@\" on %@ wall", [theWallItem message], [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Message"]) {
		message = [NSString stringWithFormat:@"%@ wrote \"%@\"", [theWallItem friendUsername], [theWallItem message]];
	} else if ([[theWallItem actionType] isEqualToString:@"Default"]) {
		message = [theWallItem message];
	} else if ([[theWallItem actionType] isEqualToString:@"Interacted"]) {
		message = [NSString stringWithFormat:@"You %@ %@", [theWallItem message], [theWallItem friendUsername]];
	} else if ([[theWallItem actionType] isEqualToString:@"Interaction"]) {
		message = [NSString stringWithFormat:@"%@ %@ you", [theWallItem friendUsername], [theWallItem message]];
	} else {
		message = @"Something cool happened in world";
	}
	NSLog(@"message: %@", message);
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


@end