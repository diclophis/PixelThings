// GPL

#import <Foundation/Foundation.h>
#import "OperationsManager.h"


@class TickerViewController;
@class RegisterViewController;
@class MainMenuViewController;
@class DecorateMenuViewController;
@class ItemSelectorViewController;
@class CharacterMenuViewController;
@class StoreViewController;
@class CommunityViewController;
@class NeighborViewController;
@class NeighborMenuViewController;
@class RoomSelectorViewController;
@class ChangeMeViewController;
@class MyStatusViewController;
@class InviteViewController;
@class SimpleExecutingViewController;


@interface MainViewController : UIViewController <ExecutingDelegate> {
	NSMutableDictionary *viewControllers;
	NSMutableDictionary *viewControllersToRelease;
	TickerViewController *tickerView;
	NSUserDefaults *defaults;
	SimpleExecutingViewController *executingView;
	Score *score;
	NSArray *forums;
	NSArray *chatrooms;
	NSString *previousAction;
	BOOL firstTime;
	BOOL secondTime;
}


@property (retain) NSMutableDictionary *viewControllers;
@property (retain) NSMutableDictionary *viewControllersToRelease;
@property (retain) TickerViewController *tickerView;
@property (retain) NSUserDefaults *defaults;
@property (retain) SimpleExecutingViewController *executingView;
@property (retain) Score *score;
@property (retain) NSString *previousAction;
@property (retain) NSArray *forums;
@property (retain) NSArray *chatrooms;
@property BOOL firstTime;
@property BOOL secondTime;


-(IBAction)didClickCharacter:(id)sender;
-(id)viewControllerFor:(NSString *)theClassName;
-(void)hideController:(NSString *)named;
-(void)showController:(NSString *)named;
-(void)beginMenuTransactions:(NSString *)animationID context:(void *)context;
-(void)endMenuTransactions:(NSString *)animationID finished:(BOOL)finished context:(void *)context;
-(void)performMainMenuAction;
-(void)performInfoMenuAction;
-(void)showController:(NSString *)named belowView:(UIView *)theView;
-(void)performNeighborsMenuAction;
-(void)performDecorateMenuAction;
-(void)performStoreMenuAction;
-(void)performCommunityMenuAction;
-(void)initiateChangeMe:(id)userData;
-(void)didPostNavigate:(id)userData;


@end
