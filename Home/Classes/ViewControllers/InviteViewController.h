#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AddressBookUI/AddressBookUI.h>
#import "OperationsManager.h"


@interface InviteViewController : UIViewController <ABPeoplePickerNavigationControllerDelegate, InviteDelegate, UITextViewDelegate> {
	ABPeoplePickerNavigationController *peopleView;
	IBOutlet id emailField;
	IBOutlet id inviteButton;
	IBOutlet id contactsButton;
	IBOutlet id message;
	IBOutlet id emailHelpImage;
	IBOutlet id messageHelpImage;
	BOOL dismissed;
	NSString *selectedAction;
}


@property (nonatomic) BOOL dismissed;
@property (nonatomic, retain) NSString *selectedAction;


-(IBAction)addContactClicked:(id)sender;
-(IBAction)inviteClicked:(id)sender;
-(void)deactivateButtons;
-(void)activateButtons;
-(IBAction)backClicked:(id)sender;


@end