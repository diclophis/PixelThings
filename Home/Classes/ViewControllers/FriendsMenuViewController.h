#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MenuViewController.h"


@interface FriendsMenuViewController : MenuViewController {
	IBOutlet UILabel *usernameLabel;
	IBOutlet UILabel *visitsLabel;
	IBOutlet UILabel *likesLabel;
	IBOutlet UILabel *pointsLabel;
	IBOutlet UILabel *friendsLabel;
	
	IBOutlet UIButton *likeButton;
	IBOutlet UIButton *backButton;
	IBOutlet UIButton *wallButton;
	IBOutlet UIButton *statsButton;
	
	NSString *fromKeyPath;
}


@property (retain) NSString *fromKeyPath;


-(IBAction)didClickBack:(id)sender;
-(IBAction)didClickLike:(id)sender;
-(IBAction)didClickStats:(id)sender;
-(IBAction)didClickWall:(id)sender;


@end