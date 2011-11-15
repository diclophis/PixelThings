// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@interface StoreItemsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, StoreItemsDelegate> {
	ItemCategory *category;
	NSArray *items;
	IBOutlet UITableView *tableView;
	UIActivityIndicatorView *activityView;
	UIButton *refreshButton;
	UIButton *backButton;
	UILabel *descriptionLabel;
	BOOL isDismissed;
	FunItem *selectedItem; 
}


@property (retain) FunItem *selectedItem;
@property (retain) ItemCategory *category;
@property (retain) NSArray *items;
@property (retain) IBOutlet UITableView *tableView;
@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *refreshButton;
@property (retain) UIButton *backButton;
@property (retain) UILabel *descriptionLabel;
@property BOOL isDismissed;


-(id)initWithCategory:(ItemCategory *)theCategory;
-(void)refresh:(id)sender;
-(void)didClickBack:(id)sender;


@end
