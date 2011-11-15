// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Forum.h"
#import "Topic.h"
#import "PaginatedTopics.h"
#import "TopicsViewController.h"
#import "PostsViewController.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"
#import "NSDateAdditions.h"


@implementation TopicsViewController


@synthesize topics;
@synthesize tableView;
@synthesize forum;
@synthesize pager;
@synthesize loadMoreButton;
@synthesize activityView;
@synthesize refreshButton;
@synthesize forumDescriptionLabel;
@synthesize addTopicButton;
@synthesize inputField;
@synthesize cancelButton;
@synthesize postsView;
@synthesize backButton;
@synthesize isDismissed;
@synthesize rulesButton;
@synthesize viewForumRules;


-(id)initWithForum:(Forum *)theForum {
	if ((self = [super initWithNibName:@"TopicsViewController" bundle:[NSBundle mainBundle]])) {
		[self setForum:theForum];
		
		[self setTopics:nil];
		
		[[OperationsManager sharedInstance] setTopicsDelegate:self];

		
		//BACK BUTTON
		[self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[backButton setAdjustsImageWhenHighlighted:YES];
		[backButton setImage:[UIImage imageNamed:@"ui_forumback.png"] forState:UIControlStateNormal];
		[backButton setFrame:CGRectMake(5.0f, 5.0f, 30.0f, 30.0f)];
		[backButton addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//DESCRIPTION LABEL
		UILabel *theForumDescriptionLabel = [[UILabel alloc] init];
		[self setForumDescriptionLabel:theForumDescriptionLabel];
		[theForumDescriptionLabel release];
		[forumDescriptionLabel setFrame:CGRectMake(40.0f, 5.0f, 360.0f, 30.0f)];
		[forumDescriptionLabel setText:[forum forumDescription]];
		[forumDescriptionLabel setBackgroundColor:[UIColor clearColor]];
		[forumDescriptionLabel setTextColor:[UIColor whiteColor]];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		

		//ADD BUTTON
		[self setAddTopicButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[addTopicButton setAdjustsImageWhenHighlighted:YES];
		[addTopicButton setImage:[UIImage imageNamed:@"ui_forumnewtopic.png"] forState:UIControlStateNormal];
		[addTopicButton setFrame:CGRectMake(405.0f, 5.0f, 30.0f, 30.0f)];
		[addTopicButton addTarget:self action:@selector(didClickAddTopic:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//RULES BUTTON
		[self setRulesButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[rulesButton setAdjustsImageWhenHighlighted:YES];
		[rulesButton setImage:[UIImage imageNamed:@"ui_forumrulesbutton.png"] forState:UIControlStateNormal];
		[rulesButton setFrame:CGRectMake(405.0f, 5.0f, 38.0f, 30.0f)];
		[rulesButton addTarget:self action:@selector(didClickRules:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//LOADMORE BUTTON
		[self setLoadMoreButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[loadMoreButton setAdjustsImageWhenHighlighted:YES];
		[loadMoreButton setImage:[UIImage imageNamed:@"ui_forumloadmore.png"] forState:UIControlStateNormal];
		[loadMoreButton setFrame:CGRectMake(5.0, 5.0, 470.0, 30.0)];
		[loadMoreButton addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside];

		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
		
		
		//CANCEL BUTTON
		[self setCancelButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[cancelButton setAdjustsImageWhenHighlighted:YES];
		[cancelButton setImage:[UIImage imageNamed:@"ui_forummessageclose.png"] forState:UIControlStateNormal];
		[cancelButton setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
		[cancelButton setTitle:@"X" forState:UIControlStateNormal];
		[cancelButton addTarget:self action:@selector(didClickCancel:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//INPUT FIELD
		UITextField *theInputField = [[UITextField alloc] init];
		[self setInputField:theInputField];
		[theInputField release];
		[inputField setDelegate:self];
		[inputField setFrame:CGRectMake(480.0f, 0.0f, 480.0f, 90.0f)];
		[inputField setBorderStyle:UITextBorderStyleLine];
		[inputField setPlaceholder:@"Type your new topic here..."];
		[inputField setBackgroundColor:[UIColor whiteColor]];
		[inputField setLeftView:cancelButton];
		[inputField setLeftViewMode:UITextFieldViewModeAlways];
		[inputField setReturnKeyType:UIReturnKeyGo];
		[inputField setEnablesReturnKeyAutomatically:YES];
	}
	return self;
}


-(void)dealloc {
	[rulesButton release];
	[loadMoreButton release];
	[activityView release];
	[refreshButton release];
	[forumDescriptionLabel release];
	[addTopicButton release];
	[inputField release];
	[cancelButton release];
	[backButton release];
	[postsView release];
	[pager release];
	[forum release];
	[topics release];
	[super dealloc];
}


-(void)viewDidLoad {
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:backButton];
	[[tableView tableHeaderView] addSubview:forumDescriptionLabel];
	[[tableView tableHeaderView] addSubview:refreshButton];
	[[tableView tableHeaderView] addSubview:rulesButton];

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
	[addTopicButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchTopics:[forum id] forPage:1];
}


-(void)viewWillDisappear:(BOOL)animated {
	[tableView release];
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	if (postsView) {
		[postsView removeObserver:self forKeyPath:@"isDismissed"];
	}
	[inputField resignFirstResponder];
	[postsView viewWillDisappear:animated];
	[[OperationsManager sharedInstance] setTopicsDelegate:nil];
	[super viewWillDisappear:animated];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	[[OperationsManager sharedInstance] saveTopicInForum:[forum id] withTitle:[inputField text]];
	[inputField resignFirstResponder];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[inputField setFrame:CGRectOffset([inputField frame], 480.0f, 0.0f)];
	[UIView commitAnimations];
	return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if ([[textField text] length] < 140) {
		return YES;
	} else {
		return NO;
	}
}		

-(void)didFetchTopics:(PaginatedTopics *)thePager {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[addTopicButton setHidden:NO];
	[self setPager:nil];
	[self setPager:thePager];
	if ([pager currentPage] > 1) {
		[self setTopics:[topics arrayByAddingObjectsFromArray:[pager topics]]];
	} else {
		[self setTopics:[pager topics]];
	}
	[tableView reloadData];
	if ([pager totalPages] > [pager currentPage]) {
		[loadMoreButton setHidden:NO];
	}
}


-(void)didNotFetchTopics {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)didSaveTopic {
	[self refresh:nil];
}


-(void)didNotSaveTopic {
}

-(void)loadMore:(id)sender {
	[loadMoreButton setHidden:YES];
	[addTopicButton setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[[OperationsManager sharedInstance] fetchTopics:[forum id] forPage:[pager currentPage] + 1];
}


-(void)refresh:(id)sender {
	[loadMoreButton setHidden:YES];
	[refreshButton setHidden:YES];
	[addTopicButton setHidden:YES];
	[activityView startAnimating];
	[self setTopics:nil];
	[tableView reloadData];
	[[OperationsManager sharedInstance] fetchTopics:[forum id] forPage:1];
}


-(void)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


-(void)didClickRules:(id)sender {
	[self setViewForumRules:YES];
}


-(void)didClickAddTopic:(id)sender {
	[inputField setText:@""];
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
	
	UILabel *title, *username, *posts, *recent;
	
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 60);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"topicsCell"] autorelease];		
		
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
		
		posts = [[[UILabel alloc] initWithFrame:CGRectMake(425.0, 5.0, 50.0, 50.0)] autorelease];
		[posts setBackgroundColor:[UIColor clearColor]];
		[posts setTag:3];
		[posts setFont:[UIFont boldSystemFontOfSize:15.0]];
		[posts setTextAlignment:UITextAlignmentCenter];
		[posts setTextColor:[UIColor whiteColor]];
		[posts setMinimumFontSize:5.0f];
		[posts setAdjustsFontSizeToFitWidth:YES];
		[posts setLineBreakMode:UILineBreakModeWordWrap];
		[posts setNumberOfLines:2];
		
		
		recent = [[[UILabel alloc] initWithFrame:CGRectMake(215.0, 40.0, 415.0, 15.0)] autorelease];
		[recent setBackgroundColor:[UIColor clearColor]];
		[recent setTag:4];
		[recent setFont:[UIFont systemFontOfSize:11.0]];
		[recent setTextAlignment:UITextAlignmentLeft];
		[recent setTextColor:[UIColor whiteColor]];
		[recent setMinimumFontSize:5.0f];
		[recent setAdjustsFontSizeToFitWidth:YES];
		[recent setLineBreakMode:UILineBreakModeWordWrap];
		[recent setNumberOfLines:1];
		
		[cell.contentView addSubview:title];
		[cell.contentView addSubview:username];
		[cell.contentView addSubview:recent];
		[cell.contentView addSubview:posts];

	} else {
		title = (UILabel *)[cell.contentView viewWithTag:1];
		username = (UILabel *)[cell.contentView viewWithTag:2];
		posts = (UILabel *)[cell.contentView viewWithTag:3];
		recent = (UILabel *)[cell.contentView viewWithTag:4];
	}
	
	Topic *topic = [topics objectAtIndex:[indexPath row]];
	[title setText:[topic title]];
	[username setText:[NSString stringWithFormat:@"by: %@ %@", [topic username], [[[topic createdAt] date] timeAgo]]];
	if ([[topic latestUsername] length] > 0) {
		[recent setText:[NSString stringWithFormat:@"recent: %@ %@", [topic latestUsername], [[[topic latestCreatedAt] date] timeAgo]]];
	}

	[posts setText:[NSString stringWithFormat:@"%d\nposts", [topic posts_count]]];
	return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [topics count];
}


-(void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (postsView) {
		[postsView removeObserver:self forKeyPath:@"isDismissed"];
	}
	
	PostsViewController *thePostsView = [[PostsViewController alloc] initWithTopic:[topics objectAtIndex:[indexPath row]]];
	[self setPostsView:thePostsView];
	[thePostsView release];
	[postsView addObserver:self forKeyPath:@"isDismissed" options:NSKeyValueObservingOptionNew context:nil];

	[postsView viewWillAppear:YES];
	[[self view] addSubview:[postsView view]];
	[[postsView view] setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[[postsView view] setFrame:[tableView frame]];
	[tableView setFrame:CGRectOffset([tableView frame], -480.0f, 0.0f)];
	[UIView commitAnimations];
}


-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0f;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"isDismissed"]) {
		[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
		if ([object isKindOfClass:[PostsViewController class]]) {
			[postsView removeObserver:self forKeyPath:@"isDismissed"];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDuration:ANIMATION_DURATION];
			[self viewWillAppear:YES];
			[postsView viewWillDisappear:YES];
			[[postsView view] setFrame:CGRectOffset([[postsView view] frame], 480.0f, 0.0f)];
			[tableView setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
			[UIView commitAnimations];
			[self setPostsView:nil];
		}
	}
}


@end
