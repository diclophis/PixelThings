// GPL

#import "AddFriendViewController.h"
#import "OperationsManager.h"


@implementation AddFriendViewController


@synthesize isDismissed;


-(id)init {
	if ((self = [super initWithNibName:@"AddFriendViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)dealloc {
	[super dealloc];
}


-(IBAction)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


-(void)viewWillDisappear:(BOOL)animated {
	[nicknameField resignFirstResponder];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	if ([textField isEqual:nicknameField]) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[nicknameHelpImage setAlpha:0.0f];
		[UIView commitAnimations];
	}
}


-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if([string isEqualToString:@"\n"]) {
		return NO;
	}
	NSRange spaceRange = [string rangeOfString:@" "];
	if (spaceRange.location == NSNotFound) {
		NSString *newString = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
		return !([newString length] > 40);
	} else {
		return NO;
	}
}


-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if ([[nicknameField text] length] > 0) {
		[[OperationsManager sharedInstance] addFriend:[nicknameField text]];
		[nicknameField resignFirstResponder];
	}
	return YES;
}


@end
