#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@interface FriendsListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
	IBOutlet UITableView *tableView;
	NSMutableDictionary *roster;
	NSString *friendToVisit;
	UIButton *backButton;
	UILabel *titleLabel;
	BOOL isDismissed;
}


@property (retain) UIButton *backButton;
@property (retain) NSMutableDictionary *roster;
@property (retain) NSString *friendToVisit;
@property (retain) UILabel *titleLabel;
@property BOOL isDismissed;


-(NSInteger)onlineFriends;
-(IBAction)didClickBack:(id)sender;


@end