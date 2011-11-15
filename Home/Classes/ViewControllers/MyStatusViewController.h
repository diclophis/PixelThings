// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"


@interface MyStatusViewController : DrawerViewController {
	IBOutlet UITextField *textField;
}


-(IBAction)didClickBack:(id)sender;
-(IBAction)didClickSave:(id)sender;


@end
