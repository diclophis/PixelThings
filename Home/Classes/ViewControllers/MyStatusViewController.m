// GPL

#import "MyStatusViewController.h"
#import "OperationsManager.h"


@implementation MyStatusViewController


-(id)init {
	if ((self = [super initWithNibName:@"MyStatusViewController" bundle:[NSBundle mainBundle]])) {
		//
	}
	return self;
}


-(void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[textField becomeFirstResponder];
}	


-(IBAction)didClickBack:(id)sender {
	[textField resignFirstResponder];
	[self setSelectedAction:@"Main"];
}


-(IBAction)didClickSave:(id)sender {
}


-(BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if([string isEqualToString:@"\n"]) {
		return NO;
	}
	NSString *newString = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
	return !([newString length] > 65);
}

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	if ([[theTextField text] length] > 0) {
		[[OperationsManager sharedInstance] updateStatus:[theTextField text]];
		[textField resignFirstResponder];
		[self setSelectedAction:@"Main"];
	}
	return YES;
}



@end
