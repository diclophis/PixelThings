#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DrawerViewController.h"


@class FriendsListViewController;
@class AddFriendViewController;
@class ChatRoomsViewController;
@class TopicsViewController;


@interface CommunityViewController : DrawerViewController {
	IBOutlet UIView *tableView;
	IBOutlet UILabel *forumsLabel;
	IBOutlet UILabel *chatroomsLabel;
	IBOutlet UILabel *friendsLabel;
	FriendsListViewController *friendsListView;
	AddFriendViewController *addFriendView;
	TopicsViewController *topicsView;
	NSArray *forums;
	NSArray *chatrooms;
}


@property (retain) NSArray *forums;
@property (retain) NSArray *chatrooms;
@property (retain) FriendsListViewController *friendsListView;
@property (retain) AddFriendViewController *addFriendView;
@property (retain) TopicsViewController *topicsView;


-(IBAction)didClickClose:(id)sender;
-(void)didStopDismissing:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
-(IBAction)didClickFriends:(id)sender;
-(IBAction)didClickInvite:(id)sender;
-(IBAction)didClickNeighbors:(id)sender;
-(IBAction)didClickAddFriend:(id)sender;
-(IBAction)didClickForum:(id)sender;
-(IBAction)didClickChat:(id)sender;
-(IBAction)didClickFacebook:(id)sender;


@end