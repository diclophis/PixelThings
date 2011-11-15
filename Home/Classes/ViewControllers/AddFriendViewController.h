// GPL

#import <Foundation/Foundation.h>

@interface AddFriendViewController : UIViewController {
	IBOutlet id nicknameHelpImage;
	IBOutlet UITextField *nicknameField;
	BOOL isDismissed;
}


@property BOOL isDismissed;


-(IBAction)didClickBack:(id)sender;


@end
