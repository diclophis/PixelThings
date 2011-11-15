// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"
#import "OperationsManager.h"


@class StoreItemsViewController;


@interface StoreViewController : DrawerViewController <UITableViewDataSource, UITableViewDelegate, StoreDelegate> {
	StoreItemsViewController *storeItemsView;
	NSArray *categories;
	UIActivityIndicatorView *activityView;
	UIButton *refreshButton;	
	UILabel *titleLabel;
}


@property (retain) StoreItemsViewController *storeItemsView;
@property (retain) NSArray *categories;
@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *refreshButton;
@property (retain) UILabel *titleLabel;
@property (retain) IBOutlet UITableView *tableView;


-(IBAction)didClickClose:(id)sender;


@end