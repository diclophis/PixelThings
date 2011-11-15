// GPL

#import <UIKit/UIKit.h>


@interface LoginController : UIViewController {
	NSUserDefaults *dflts;
	IBOutlet UITextField *usernameLabel;
	IBOutlet UITextField *passwordLabel;

}


@property (nonatomic, retain) NSUserDefaults *dflts;

-(IBAction)dismissKeyboard:(id)sender;
-(IBAction)didClickReturn:(id)sender;



@end
