#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class RoomViewController;


@interface RoomSelectorViewController : UIViewController <UIScrollViewDelegate> {
	IBOutlet UIScrollView *scrollView;
  NSMutableArray *viewControllers;
	NSInteger currentPage;
	RoomViewController *activeRoomView;
	BOOL editing;
}


@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) NSMutableArray *viewControllers;
@property (nonatomic, retain) RoomViewController *activeRoomView;
@property BOOL editing;


-(void)loadScrollViewWithPage:(int)page;
-(void)activateCurrentPage;
-(void)cancelEditMode;


@end
