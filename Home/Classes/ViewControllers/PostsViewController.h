// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@interface PostsViewController : UIViewController <PostsDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
	UIActivityIndicatorView *activityView;
	UIButton *loadMoreButton;
	UIButton *refreshButton;
	UIButton *addPostButton;
	UIButton *cancelButton;
	UIButton *backButton;
	
	UILabel *topicTitleLabel;	
	UITextField *inputField;
	
	NSArray *posts;
	Topic *topic;
	PaginatedPosts *pager;
	
	IBOutlet UITableView *tableView;
	BOOL isDismissed;
}


@property (retain) Topic *topic;
@property (retain) PaginatedPosts *pager;
@property (retain) NSArray *posts;
@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *loadMoreButton;
@property (retain) UIButton *refreshButton;
@property (retain) UIButton *addPostButton;
@property (retain) UIButton *cancelButton;
@property (retain) UIButton *backButton;
@property BOOL isDismissed;
@property (retain) UILabel *topicTitleLabel;
@property (retain) UITextField *inputField;
@property (retain) IBOutlet UITableView *tableView;


-(id)initWithTopic:(Topic *)theTopic;
-(void)refresh:(id)sender;
-(void)loadMore:(id)sender;
-(void)didClickAddPost:(id)sender;
-(void)didClickCancel:(id)sender;
-(void)didClickBack:(id)sender;


@end
