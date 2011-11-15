#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MenuViewController.h"
#import "AnimatedObject.h"
#import "AnimatedPerson.h"


@interface MainMenuViewController : MenuViewController {
	IBOutlet UIButton *homeButton;
	IBOutlet UILabel *usernameLabel;
	IBOutlet UILabel *visitsLabel;
	IBOutlet UILabel *likesLabel;
	IBOutlet UILabel *pointsLabel;
	IBOutlet UILabel *friendsLabel;
	Score *score;
	UIImage *wallItemsBackground;
	UIButton *wallItemsButton;
}


@property (retain) Score *score;
@property (retain) UIImage *wallItemsBackground;
@property (retain) UIButton *wallItemsButton;


-(IBAction)didClickHome:(id)sender;
-(IBAction)didClickDecorate:(id)sender;
-(IBAction)didClickMe:(id)sender;
-(IBAction)didClickWall:(id)sender;
-(IBAction)didClickStore:(id)sender;
-(IBAction)didClickCommunity:(id)sender;
-(IBAction)didClickGame:(id)sender;
-(IBAction)didClickStats:(id)sender;


-(void)updateScore:(Score *)theScore;
-(void)updateNewWallItemsCount;

@end