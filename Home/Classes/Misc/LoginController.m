// GPL

#import "LoginController.h"
#import "OperationsManager.h"
#import "AnimatedPerson.h"
#import "AnimationSystem.h"

@implementation LoginController


@synthesize dflts;

-(id)init {
	if ((self = [super initWithNibName:@"LoginController" bundle:[NSBundle mainBundle]])) {
		[self setDflts:[NSUserDefaults standardUserDefaults]];
	}
	return self;
}


-(void)dealloc {
	[dflts release];
    [super dealloc];
}


-(void)viewWillAppear:(BOOL)animated {
	[passwordLabel setText:@""];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	BOOL hasNickname = [[usernameLabel text] length] > 0;
	BOOL hasPassword = [[passwordLabel text] length] > 0;
	if (hasNickname && !hasPassword) {
		[usernameLabel resignFirstResponder];
		[passwordLabel becomeFirstResponder];
		return YES;
	} else if (hasNickname && hasPassword) {
		[usernameLabel resignFirstResponder];
		[passwordLabel resignFirstResponder];
		[dflts setObject:[usernameLabel text] forKey:@"Account.JID"];
		[dflts setObject:[passwordLabel text] forKey:@"Account.Password"];
		[[OperationsManager sharedInstance] authenticate];
		return YES;
	} else {
		return NO;
	}
}


-(void)viewDidLoad {
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	NSRange spaceRange = [string rangeOfString:@" "];
	if (spaceRange.location == NSNotFound) {
		NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
		if ([textField isEqual:usernameLabel]) {
			return !([newString length] > 40);
		} else {
			return YES;
		}
	}
	return NO;
}


-(IBAction)didClickReturn:(id)sender {
	[[self view] setHidden:YES];
}

-(IBAction)dismissKeyboard:(id)sender {
	[usernameLabel resignFirstResponder];
	[passwordLabel resignFirstResponder];
	
}

@end
