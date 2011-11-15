#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@class RoomViewController;


@interface NeighborViewController : UIViewController <UIScrollViewDelegate, AvatarViewingDelegate> {
	UIImageView *imageView;
	Score *score;
	RoomViewController *roomView;
	NSInteger modulator;
}


@property NSInteger modulator;
@property (retain) UIImageView *imageView;
@property (retain) Score *score;
@property (retain) RoomViewController *roomView;


@end