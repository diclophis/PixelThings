// GPL

#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Post.h"
#import "Forum.h"
#import "Topic.h"
#import "PaginatedPosts.h"
#import "OperationsManager.h"
#import "PostsViewController.h"

@implementation PostsViewController


@synthesize posts;
@synthesize tableView;
@synthesize topic;
@synthesize pager;
@synthesize loadMoreButton;
@synthesize activityView;
@synthesize refreshButton;
@synthesize topicTitleLabel;
@synthesize addPostButton;
@synthesize inputField;
@synthesize cancelButton;
@synthesize isDismissed;
@synthesize backButton;


-(id)initWithTopic:(Topic *)theTopic {
	if ((self = [super initWithNibName:@"PostsViewController" bundle:[NSBundle mainBundle]])) {
		[self setTopic:theTopic];
		
		[self setPosts:nil];		
		
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
		
		
		UILabel *theTopicTitleLabel = [[UILabel alloc] init];
		[self setTopicTitleLabel:theTopicTitleLabel];
		[theTopicTitleLabel release];
		[topicTitleLabel setFrame:CGRectMake(40.0f, 5.0f, 360.0f, 30.0f)];
		[topicTitleLabel setText:[topic title]];
		[topicTitleLabel setBackgroundColor:[UIColor clearColor]];
		[topicTitleLabel setTextColor:[UIColor whiteColor]];
		
		
		//ADDPOST BUTTON
		[self setAddPostButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[addPostButton setAdjustsImageWhenHighlighted:YES];
		[addPostButton setImage:[UIImage imageNamed:@"ui_forumadd.png"] forState:UIControlStateNormal];
		[addPostButton setFrame:CGRectMake(405.0f, 5.0f, 30.0f, 30.0f)];
		[addPostButton setTitle:@"+" forState:UIControlStateNormal];
		[addPostButton addTarget:self action:@selector(didClickAddPost:) forControlEvents:UIControlEventTouchUpInside];
		
		
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
		
		
		//CANCEL BUTTON
		[self setCancelButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[cancelButton setAdjustsImageWhenHighlighted:YES];
		[cancelButton setImage:[UIImage imageNamed:@"ui_forummessageclose.png"] forState:UIControlStateNormal];
		[cancelButton setFrame:CGRectMake(0.0, 0.0, 30.0, 90.0)];
		[cancelButton setTitle:@"X" forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchUpInside];
		
		
		UITextField *theInputField = [[UITextField alloc] init];
		[self setInputField:theInputField];
		[theInputField release];
		[inputField setDelegate:self];
		[inputField setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 90.0f)];
		[inputField setBorderStyle:UITextBorderStyleLine];
		[inputField setPlaceholder:@"Type your new post here..."];
		[inputField setBackgroundColor:[UIColor whiteColor]];
		[inputField setLeftView:cancelButton];
		[inputField setLeftViewMode:UITextFieldViewModeAlways];
		[inputField setReturnKeyType:UIReturnKeyGo];
		[inputField setEnablesReturnKeyAutomatically:YES];
		
		[[OperationsManager sharedInstance] setPostsDelegate:self];
	}
	return self;
}


-(void)dealloc {
	[loadMoreButton release];
	[activityView release];
	[refreshButton release];
	[topicTitleLabel release];
	[addPostButton release];
	[inputField release];
	[cancelButton release];
	[backButton release];
	[tableView release];
	[pager release];
	[topic release];
	[posts release];
	[super dealloc];
}


-(void)viewDidLoad {
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	//[theHeaderView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.75f]];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:backButton];
	[[tableView tableHeaderView] addSubview:refreshButton];
	[[tableView tableHeaderView] addSubview:topicTitleLabel];

	[[tableView tableHeaderView] addSubview:addPostButton];
	
	UIView *theFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theFooterView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableFooterView:theFooterView];
	[theFooterView release];
	
	[[tableView tableFooterView] addSubview:loadMoreButton];
	[[tableView tableFooterView] addSubview:activityView];
	
	[activityView startAnimating];
	[[self view] addSubview:inputField];
}


-(void)viewWillAppear:(BOOL)animated {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[addPostButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchPosts:[topic id] forPage:1];
}


-(void)viewWillDisappear:(BOOL)animated {
	[tableView setDataSource:nil];
	[tableView setDelegate:nil];
	[inputField resignFirstResponder];
	[[OperationsManager sharedInstance] setPostsDelegate:nil];
	[super viewWillDisappear:animated];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[[OperationsManager sharedInstance] savePostInTopic:[topic id] withBody:[inputField text]];
	[inputField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], 480.0f, 0.0f)];
	[UIView commitAnimations];
	return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if ([[textField text] length] + [string length] < 140) {
		return YES;
	} else {
		return NO;
	}
}		

-(void)didFetchPosts:(PaginatedPosts *)thePager {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[addPostButton setHidden:NO];
	[self setPager:nil];
	[self setPager:thePager];
	if ([pager currentPage] > 1) {
		[self setPosts:[posts arrayByAddingObjectsFromArray:[pager posts]]];
	} else {
		[self setPosts:[pager posts]];
	}
	[[self tableView] reloadData];
	if ([pager totalPages] > [pager currentPage]) {
		[loadMoreButton setHidden:NO];
	}
}


-(void)didNotFetchPosts {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)didSavePost {
	[inputField setText:@""];
	[self refresh:nil];
}


-(void)didNotSavePost {
	[self didClickAddPost:nil];
}


-(void)loadMore:(id)sender {
	[loadMoreButton setHidden:YES];
	[addPostButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[[OperationsManager sharedInstance] fetchPosts:[topic id] forPage:[pager currentPage] + 1];
}


-(void)refresh:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[addPostButton setHidden:YES];
	[activityView startAnimating];
	[self setPosts:nil];
	[[self tableView] reloadData];
	[[OperationsManager sharedInstance] fetchPosts:[topic id] forPage:1];
}


-(void)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


-(void)didClickAddPost:(id)sender {
	[inputField becomeFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], -480.0f, 0.0f)];
	[UIView commitAnimations];
}


-(void)didClickCancel:(id)sender {
	[inputField resignFirstResponder];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], 480.0f, 0.0f)];
	[UIView commitAnimations];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"topicsCell"];
	
	UILabel *title, *username;
	
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 60);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"topicsCell"] autorelease];
		//[cell.contentView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.75f]];
		
		
		title = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 415.0, 30.0)] autorelease];
		[title setBackgroundColor:[UIColor clearColor]];
		[title setTag:1];
		[title setFont:[UIFont boldSystemFontOfSize:13.0]];
		[title setTextAlignment:UITextAlignmentLeft];
		[title setTextColor:[UIColor whiteColor]];
		[title setMinimumFontSize:5.0f];
		[title setAdjustsFontSizeToFitWidth:YES];
		[title setLineBreakMode:UILineBreakModeWordWrap];
		[title setNumberOfLines:0];
		
		username = [[[UILabel alloc] initWithFrame:CGRectMake(5.0, 40.0, 415.0, 15.0)] autorelease];
		[username setBackgroundColor:[UIColor clearColor]];
		[username setTag:2];
		[username setFont:[UIFont systemFontOfSize:11.0]];
		[username setTextAlignment:UITextAlignmentLeft];
		[username setTextColor:[UIColor whiteColor]];
		[username setMinimumFontSize:5.0f];
		[username setAdjustsFontSizeToFitWidth:YES];
		[username setLineBreakMode:UILineBreakModeWordWrap];
		[username setNumberOfLines:1];
		

		
		[cell.contentView addSubview:title];
		[cell.contentView addSubview:username];
		
	} else {
		title = (UILabel *)[cell.contentView viewWithTag:1];
		username = (UILabel *)[cell.contentView viewWithTag:2];
		
	}
	
	Post *post = [posts objectAtIndex:[indexPath row]];
	[title setText:[post body]];
	[username setText:[NSString stringWithFormat:@"by: %@", [post username]]];
	return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [posts count];
}


-(void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}


-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	return nil;
}


@end
