// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@interface RecentLikesViewController :  UIViewController <LikesDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
	UIActivityIndicatorView *activityView;
	UIButton *backButton;
	UIButton *loadMoreButton;
	UIButton *refreshButton;
	UILabel *titleLabel;
	IBOutlet UITableView *tableView;

	NSArray *likes;
	PaginatedLikes *pager;
	
	BOOL isDismissed;
	
	NSString *friendUsername;
}


@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *loadMoreButton;
@property (retain) UIButton *refreshButton;
@property (retain) UIButton *backButton;
@property (retain) UILabel *titleLabel;
@property (retain) IBOutlet UITableView *tableView;

@property (retain) NSArray *likes;
@property (retain) PaginatedLikes *pager;

@property BOOL isDismissed;

@property (retain) NSString *friendUsername;


-(id)initWithFriendUsername:(NSString *)theFriendUsername;
-(void)refresh:(id)sender;
-(void)loadMore:(id)sender;
-(void)didClickBack:(id)sender;


@end
