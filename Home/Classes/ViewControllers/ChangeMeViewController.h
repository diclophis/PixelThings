// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"


@class AvatarSelectorViewController;


@interface ChangeMeViewController : DrawerViewController {
	IBOutlet AvatarSelectorViewController *myAvatarController;
}


-(IBAction)didClickClose:(id)sender;


@end
