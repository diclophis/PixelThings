// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@class PostsViewController;


@interface TopicsViewController : UIViewController <TopicsDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
	NSArray *topics;
	UIActivityIndicatorView *activityView;
	UIButton *loadMoreButton;
	UIButton *refreshButton;
	UIButton *addTopicButton;
	UIButton *rulesButton;

	UIButton *cancelButton;
	UIButton *backButton;
	
	UILabel *forumDescriptionLabel;
	
	UITextField *inputField;
	
	IBOutlet UITableView *tableView;
	Forum *forum;
	PaginatedTopics *pager;
	
	
	PostsViewController *postsView;
	BOOL isDismissed;
	BOOL viewForumRules;
}


@property (retain) Forum *forum;
@property (retain) PaginatedTopics *pager;
@property (retain) NSArray *topics;

@property (retain) UIActivityIndicatorView *activityView;

@property (retain) UIButton *loadMoreButton;
@property (retain) UIButton *rulesButton;
@property (retain) UIButton *refreshButton;
@property (retain) UIButton *addTopicButton;
@property (retain) UIButton *cancelButton;
@property (retain) UIButton *backButton;

@property (retain) UILabel *forumDescriptionLabel;
@property (retain) UITextField *inputField;

@property (retain) IBOutlet UITableView *tableView;

@property (retain) PostsViewController *postsView;

@property BOOL isDismissed;
@property BOOL viewForumRules;


-(id)initWithForum:(Forum *)theForum;
-(void)refresh:(id)sender;
-(void)loadMore:(id)sender;
-(void)didClickAddTopic:(id)sender;
-(void)didClickCancel:(id)sender;
-(void)didClickBack:(id)sender;
-(void)didClickRules:(id)sender;

@end
