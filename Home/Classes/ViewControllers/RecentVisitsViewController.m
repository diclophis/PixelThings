// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Visit.h"
#import "PaginatedVisits.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"
#import "NSDateAdditions.h"
#import "RecentVisitsViewController.h"


@implementation RecentVisitsViewController

@synthesize visits;
@synthesize tableView;
@synthesize pager;
@synthesize loadMoreButton;
@synthesize activityView;
@synthesize refreshButton;
@synthesize titleLabel;
@synthesize isDismissed;
@synthesize backButton;
@synthesize friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername {
	if ((self = [super initWithNibName:@"PostsViewController" bundle:[NSBundle mainBundle]])) {
		[self setFriendUsername:theFriendUsername];
		
		[self setVisits:nil];
		
		
		//BACK BUTTON
		[self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[backButton setAdjustsImageWhenHighlighted:YES];
		[backButton setImage:[UIImage imageNamed:@"ui_forumback.png"] forState:UIControlStateNormal];
		[backButton setFrame:CGRectMake(5.0f, 5.0f, 30.0f, 30.0f)];
		[backButton setTitle:@"B" forState:UIControlStateNormal];
		[backButton addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton setTitle:@"%" forState:UIControlStateNormal];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		
		
		UILabel *theTitleLabel = [[UILabel alloc] init];
		[self setTitleLabel:theTitleLabel];
		[theTitleLabel release];
		[titleLabel setFrame:CGRectMake(40.0f, 5.0f, 360.0f, 30.0f)];
		[titleLabel setText:@"Most Recent Visitors"];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor whiteColor]];
		
		
		//LOADMORE BUTTON
		[self setLoadMoreButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[loadMoreButton setAdjustsImageWhenHighlighted:YES];
		[loadMoreButton setImage:[UIImage imageNamed:@"ui_forumloadmore.png"] forState:UIControlStateNormal];
		[loadMoreButton setFrame:CGRectMake(5.0, 5.0, 470.0, 30.0)];
		[loadMoreButton setTitle:@"Load More..." forState:UIControlStateNormal];
		[loadMoreButton addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];
		
		
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
		
		
				
		[[OperationsManager sharedInstance] setVisitsDelegate:self];
	}
	return self;
}


-(void)dealloc {
	[refreshButton release];
	[visits release];
	[loadMoreButton release];
	[activityView release];
	[titleLabel release];
	[backButton release];
	[friendUsername release];
	[tableView release];
	[pager release];
	[super dealloc];
}


-(void)viewDidLoad {
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:backButton];
	[[tableView tableHeaderView] addSubview:refreshButton];
	[[tableView tableHeaderView] addSubview:titleLabel];
	
	
	UIView *theFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theFooterView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableFooterView:theFooterView];
	[theFooterView release];
	
	[[tableView tableFooterView] addSubview:loadMoreButton];
	[[tableView tableFooterView] addSubview:activityView];
	
	[activityView startAnimating];
}


-(void)viewWillAppear:(BOOL)animated {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	if (friendUsername) {
		[[OperationsManager sharedInstance] fetchRecentVisits:friendUsername forPage:1];
	} else {
		[[OperationsManager sharedInstance] fetchMyRecentVisits:1];
	}
}


-(void)viewWillDisappear:(BOOL)animated {
	[tableView setDataSource:nil];
	[tableView setDelegate:nil];
	[[OperationsManager sharedInstance] setVisitsDelegate:nil];
	[super viewWillDisappear:animated];
}
		

-(void)didFetchRecentVisits:(PaginatedVisits *)thePager {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[self setPager:nil];
	[self setPager:thePager];
	if ([pager currentPage] > 1) {
		[self setVisits:[visits arrayByAddingObjectsFromArray:[pager visits]]];
	} else {
		[self setVisits:[pager visits]];
	}
	[[self tableView] reloadData];
	if ([pager totalPages] > [pager currentPage]) {
		[loadMoreButton setHidden:NO];
	}
}


-(void)didNotFetchRecentVisits {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)loadMore:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	if (friendUsername) {
		[[OperationsManager sharedInstance] fetchRecentVisits:friendUsername forPage:[pager currentPage] + 1];
	} else {
		[[OperationsManager sharedInstance] fetchMyRecentLikes:[pager currentPage] + 1];
	}
}


-(void)refresh:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[self setVisits:nil];
	[[self tableView] reloadData];
	if (friendUsername) {
		[[OperationsManager sharedInstance] fetchRecentVisits:friendUsername forPage:1];
	} else {
		[[OperationsManager sharedInstance] fetchMyRecentVisits:1];
	}
}


-(void)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"recentLikesCell"];
	UILabel *username, *timestamp;
	
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 40);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"recentLikesCell"] autorelease];		
		
		username = [[[UILabel alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 380.0f, 30.0f)] autorelease];
		[username setBackgroundColor:[UIColor clearColor]];
		[username setTag:1];
		[username setFont:[UIFont systemFontOfSize:11.0]];
		//[username setTextAlignment:UITextAlignmentLeft];
		[username setTextColor:[UIColor whiteColor]];
		//[username setMinimumFontSize:5.0f];
		[username setAdjustsFontSizeToFitWidth:YES];
		//[username setLineBreakMode:UILineBreakModeWordWrap];
		[username setNumberOfLines:1];
		
		timestamp = [[[UILabel alloc] initWithFrame:CGRectMake(390.0, 5.0, 85.0, 30.0)] autorelease];
		[timestamp setBackgroundColor:[UIColor clearColor]];
		[timestamp setTag:2];
		[timestamp setFont:[UIFont systemFontOfSize:12.0]];
		[timestamp setTextColor:[UIColor whiteColor]];
		//[timestamp setTextAlignment:UITextAlignmentRight];
		//[timestamp setMinimumFontSize:10.0f];
		[timestamp setAdjustsFontSizeToFitWidth:YES];
		[cell.contentView addSubview:timestamp];
		
		[cell.contentView addSubview:username];
		
	} else {
		username = (UILabel *)[cell.contentView viewWithTag:1];
		timestamp = (UILabel *)[cell.contentView viewWithTag:2];
	}
	
	Visit *visit = [visits objectAtIndex:[indexPath row]];
	[timestamp setText:[[[visit createdAt] date] timeAgo]];
	[username setText:[visit username]];
	
	return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [visits count];
}


-(void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 40.0f;
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


@end