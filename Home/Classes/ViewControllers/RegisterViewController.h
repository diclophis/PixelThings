#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "OperationsManager.h"
#import "LoginController.h"

@class InfoViewController;

@interface RegisterViewController : UIViewController <UITextFieldDelegate> {
	IBOutlet id nicknameField;
	IBOutlet id emailField;
	IBOutlet id passwordField;
	IBOutlet id nicknameLabel;
	IBOutlet id emailLabel;
	IBOutlet id passwordLabel;
	IBOutlet id infoButton;
	BOOL bumped;
	LoginController *loginView;
}


@property (retain) LoginController *loginView;
@property (retain) IBOutlet id nicknameField;
@property (retain) IBOutlet id passwordField;
@property (retain) IBOutlet id emailField;
@property (retain) IBOutlet id nicknameLabel;
@property (retain) IBOutlet id emailLabel;
@property (retain) IBOutlet id passwordLabel;
@property BOOL bumped;


-(IBAction)dismissKeyboard:(id)sender;
-(void)createAccount;
-(IBAction)signUp:(id)sender;
-(IBAction)login:(id)sender;


@end
