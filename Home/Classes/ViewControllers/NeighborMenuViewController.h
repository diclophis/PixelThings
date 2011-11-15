#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MenuViewController.h"


@interface NeighborMenuViewController : MenuViewController {
	IBOutlet UILabel *usernameLabel;
	IBOutlet UILabel *visitsLabel;
	IBOutlet UILabel *pointsLabel;
	IBOutlet UILabel *pointsTitleLabel;
	IBOutlet UILabel *likesLabel;
	IBOutlet UIButton *likeButton;
	IBOutlet UIButton *addButton;
	IBOutlet UIButton *randomButton;
	IBOutlet UIButton *statsButton;
	IBOutlet UILabel *visitsTitleLabel;
	IBOutlet UILabel *likesTitleLabel;
	IBOutlet UILabel *friendsLabel;
	IBOutlet UILabel *friendsTitleLabel;
}


-(IBAction)didClickBack:(id)sender;
-(IBAction)didClickLike:(id)sender;
-(IBAction)didClickAdd:(id)sender;
-(IBAction)didClickRandom:(id)sender;
-(IBAction)didClickStats:(id)sender;


@end
