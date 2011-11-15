// GPL

#import <Foundation/Foundation.h>
#import "MenuViewController.h"
#import "OperationsManager.h"


@class ItemSelectorScrollView;


@interface ItemSelectorViewController : MenuViewController <UIScrollViewDelegate, RoomEditingDelegate> {
	IBOutlet ItemSelectorScrollView *scrollView;
	NSString *activeCategoryKey;
	NSMutableArray *items;
	NSMutableArray *visibleItems;
	Item *activeItem;
	Item *itemToDrop;
	BOOL canGoForward;
	BOOL canGoBackward;
	CGFloat currentPage;
	IBOutlet UIView *dropzoneView;
	
	UILabel *emptyItemsLabel;
	UIActivityIndicatorView *activityView;
	UIButton *refreshButton;
}


@property (retain) UILabel *emptyItemsLabel;
@property (retain) UIActivityIndicatorView *activityView;
@property (retain) UIButton *refreshButton;
@property (nonatomic, retain) Item *itemToDrop;
@property (nonatomic, retain) Item *activeItem;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSString *activeCategoryKey;
@property (nonatomic, retain) IBOutlet ItemSelectorScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *visibleItems;


-(IBAction)didClickBack:(id)sender;
-(IBAction)didClickPreviousPage:(id)sender;
-(IBAction)didClickNextPage:(id)sender;


-(void)loadItems:(NSString *)theType;
-(void)loadItem:(NSInteger)i;
-(void)unloadItem:(NSInteger)i;
-(void)scrollViewDidEndScrolling;
-(IBAction)reload:(id)sender;


@end
