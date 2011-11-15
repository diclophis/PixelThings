#import "RegisterViewController.h"

#import "OperationsManager.h"
#import "NSStringAdditions.h"
#import "LoginController.h"


@implementation RegisterViewController


@synthesize nicknameField;
@synthesize emailField;
@synthesize passwordField;
@synthesize nicknameLabel;
@synthesize emailLabel;
@synthesize passwordLabel;
@synthesize bumped;
@synthesize loginView;


-(id)init {
	if ((self = [super initWithNibName:@"RegisterViewController" bundle:[NSBundle mainBundle]])) {
		LoginController *theLoginView = [[LoginController alloc] init];
		[self setLoginView:theLoginView];
		[theLoginView release];
		[[loginView view] setHidden:YES];
		[[self view] addSubview:[loginView view]];
	}
	return self;
}


-(void)dealloc {
	[nicknameField release];
	[emailField release];
	[passwordField release];
	[nicknameLabel release];
	[emailLabel release];
	[passwordLabel release];
	[loginView release];
	[super dealloc];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
	[emailField becomeFirstResponder];
}


-(IBAction)login:(id)sender {
	[loginView viewWillAppear:NO];
	[[loginView view] setHidden:NO];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	BOOL aok = NO;
	BOOL hasNickname = [[nicknameField text] length] > 0;
	BOOL hasEmail = [[emailField text] length] > 0;
	BOOL hasPassword = [[passwordField text] length] > 0;
	
	if ([textField isEqual:nicknameField] && hasNickname) {
		[passwordField becomeFirstResponder];
		aok = YES;
	} else if ([textField isEqual:emailField] && hasEmail) {
		if (hasNickname && hasEmail) {
			[passwordField setReturnKeyType:UIReturnKeyJoin];
		} else {
			[passwordField setReturnKeyType:UIReturnKeyNext];
		}
		[nicknameField becomeFirstResponder];
		aok = YES;
	} else if ([textField isEqual:passwordField]) {
		if (hasNickname && hasEmail && hasPassword) {
			[self createAccount];
			[passwordField resignFirstResponder];
		} else if (!hasNickname) {
			//[realnameField becomeFirstResponder];
		} else if (!hasEmail) {
			//[emailField becomeFirstResponder];
		} else if (!hasPassword) {
			//[passwordField becomeFirstResponder];
		}
	}
	if (aok) {
		return YES;
	} else {
		return NO;
	}
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if ([textField.text length] + 1 > 40) {
		return NO;
	} else {
		if ([textField isEqual:nicknameField] || [textField isEqual:emailField]) {
			NSRange spaceRange = [string rangeOfString:@" "];
			if (spaceRange.location == NSNotFound) {
				return YES;
			} else {
				return NO;
			}
		} else {
			return YES;
		}
	}
}


-(IBAction)signUp:(id)sender {
	[self createAccount];
}


- (void)createAccount {
	NSString *nickname = [nicknameField text];
	NSString *email = [emailField text];
	NSString *password = [passwordField text];
	
	[[OperationsManager sharedInstance] registerUsername:nickname andEmail:email andPassword:password];
}


-(IBAction)dismissKeyboard:(id)sender {
	[nicknameField resignFirstResponder];
	[emailField resignFirstResponder];
	[passwordField resignFirstResponder];
}


@end
