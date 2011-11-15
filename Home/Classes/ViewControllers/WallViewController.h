#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DrawerViewController.h"
#import "OperationsManager.h"


@class PaginatedWallItems;
@class WallItem;
@class AdViewController;


@interface WallViewController : DrawerViewController <WallDelegate, UITableViewDelegate, UITableViewDataSource> {
	NSString *username;
	NSString *friendUsername;
	NSArray *wallItems;
	IBOutlet UITableView *tableView;
	UIActivityIndicatorView *activityView;
	UIButton *loadMoreButton;
	UIButton *refreshButton;
	UILabel *descriptionLabel;
	PaginatedWallItems *pager;
	IBOutlet AdViewController *myAdViewController;


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




-(NSString *)messageForWallItem:(WallItem *)theWallItem;
-(IBAction)didClickClose:(id)sender;
-(void)refresh:(id)sender;
-(void)loadMore:(id)sender;


@end
