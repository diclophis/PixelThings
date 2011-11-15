#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "InviteViewController.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"


@implementation InviteViewController


@synthesize dismissed;
@synthesize selectedAction;


-(id)init {
	if ((self = [super initWithNibName:@"InviteViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)dealloc {
	[selectedAction release];
	[super dealloc];
}

-(void)viewDidLoad {
	[self deactivateButtons];

	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];	
}


-(void)viewWillAppear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];

}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];
}


-(IBAction)addContactClicked:(id)sender {
	peopleView = [[ABPeoplePickerNavigationController alloc] init];
	NSNumber *newNumber = [[NSNumber alloc] initWithInt:kABPersonEmailProperty];
	[peopleView setDisplayedProperties:[NSArray arrayWithObject:newNumber]];
	[peopleView setPeoplePickerDelegate:self];
	[[peopleView view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
	[[self view] addSubview:[peopleView view]];
	[newNumber release];
}





-(IBAction)inviteClicked:(id)sender {
	[[OperationsManager sharedInstance] setInvitingDelegate:self];

	[[OperationsManager sharedInstance] sendInviteWithMessage:[message text] toEmail:[emailField text]];
	[emailField resignFirstResponder];
	[message resignFirstResponder];
}


-(void)didSendInvite {
	[[OperationsManager sharedInstance] setInvitingDelegate:nil];
	[emailField setText:@""];
}


-(void)didNotSendInvite {
	[[OperationsManager sharedInstance] setInvitingDelegate:nil];
}


-(void)deactivateButtons {
	[inviteButton setEnabled:NO];
}


-(void)activateButtons {
	[inviteButton setEnabled:YES];
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	return YES;
}


-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)thePeoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
	NSString *stringValue = nil;
	id theProperty = (id) ABRecordCopyValue(person, property);
	NSArray *someArray = (NSArray *) ABMultiValueCopyArrayOfAllValues(theProperty);
	stringValue = [someArray objectAtIndex:identifier];
	[someArray release];
	[emailField setText:stringValue];
	[[peopleView view] removeFromSuperview];
	[peopleView release];
	CFRelease(theProperty);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	[emailHelpImage setAlpha:0.0f];
	[UIView commitAnimations];
	return NO;
}


-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[[peopleView view] removeFromSuperview];
	[peopleView release];
}


-(IBAction)backClicked:(id)sender {
	[emailField resignFirstResponder];
	[message resignFirstResponder];
	[self setSelectedAction:@"Community"];
}


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	if([text isEqualToString:@"\n"]) {
		[message resignFirstResponder];
		return NO;
	}
	return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
	if ([textField isEqual:emailField]) {
		NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
		if ([newString validatesAsEmailAddress]) {
			[self activateButtons];
		} else {
			[self deactivateButtons];
		}
		return !([newString length] > 35);
	}
	return NO;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	if ([textField isEqual:emailField]) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[emailHelpImage setAlpha:0.0f];
		[UIView commitAnimations];
	}
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
	if ([textView isEqual:message]) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[messageHelpImage setAlpha:0.0f];
		[UIView commitAnimations];
	}
}


-(void)textViewDidEndEditing:(UITextView *)textView {
}


@end
