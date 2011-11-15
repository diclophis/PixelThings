#import "DecorateMenuViewController.h"

@implementation DecorateMenuViewController

-(IBAction)didClickToggle:(id)sender {
	[self toggle];
}


-(IBAction)didClickBack:(id)sender {
	[self setSelectedAction:@"Main"];
}	


-(IBAction)didClickBackgrounds:(id)sender {
	[self setSelectedAction:@"Backgrounds"];

}


-(IBAction)didClickFurniture:(id)sender {
	[self setSelectedAction:@"Furniture"];

}


-(IBAction)didClickPeople:(id)sender {
	[self setSelectedAction:@"People"];

}


-(IBAction)didClickAnimals:(id)sender {
	[self setSelectedAction:@"Animals"];

}


-(IBAction)didClickMisc:(id)sender {
	[self setSelectedAction:@"Misc"];

}


-(IBAction)didClickSave:(id)sender {
	[self setSelectedAction:@"PublishRoom"];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[self setSelectedAction:@"PublishRoom"];
	} else if (buttonIndex == 2) {
		[self setSelectedAction:@"Main"];
	} else {
	}
}


@end
