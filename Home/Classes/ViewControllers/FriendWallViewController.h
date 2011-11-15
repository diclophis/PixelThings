// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"
#import "OperationsManager.h"


@interface FriendWallViewController : DrawerViewController <WallDelegate, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate> {
	NSString *username;
	NSString *friendUsername;
	NSArray *wallItems;
	IBOutlet UITableView *tableView;
	
	UIActivityIndicatorView *activityView;
	UIButton *loadMoreButton;
	UIButton *refreshButton;
	UILabel *descriptionLabel;
	PaginatedWallItems *pager;
	
	UITextView *inputField;
	UIButton *cancelButton;
	UIButton *addButton;
}

@property (retain) NSString *username;
@property (retain) NSString *friendUsername;
@property (retain) NSArray *wallItems;
@property (retain) PaginatedWallItems *pager;
@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *loadMoreButton;
@property (retain) UIButton *refreshButton;
@property (retain) UILabel *descriptionLabel;
@property (retain) IBOutlet UITableView *tableView;


@property (retain) UITextView *inputField;
@property (retain) UIButton *cancelButton;
@property (retain) UIButton *addButton;


-(NSString *)messageForWallItem:(WallItem *)theWallItem;
-(void)refresh:(id)sender;
-(void)loadMore:(id)sender;
-(IBAction)didClickClose:(id)sender;


@end
