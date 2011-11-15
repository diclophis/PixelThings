// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@class RoomViewController;


@interface FriendViewController : UIViewController <AvatarViewingDelegate> {
	IBOutlet UIScrollView *scrollView;
	NSString *username;
	Score *score;
	RoomViewController *roomView;
}


@property (retain) IBOutlet UIScrollView *scrollView;
@property (retain) NSString *username;
@property (retain) Score *score;
@property (retain) RoomViewController *roomView;




@end
