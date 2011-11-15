// GPL

#import "ChangeMeViewController.h"
#import "AnimationSystem.h"
#import "OperationsManager.h"
#import "AnimatedPerson.h"
#import "AvatarSelectorViewController.h"


@implementation ChangeMeViewController


-(void)dealloc {
	[myAvatarController release];
	[super dealloc];
}


-(id)init {
	if ((self = [super initWithNibName:@"ChangeMeViewController" bundle:[NSBundle mainBundle]])) {

	}
	return self;
}


-(void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[myAvatarController viewWillDisappear:animated];
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[myAvatarController viewWillAppear:animated];
}

-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"CloseChangeMe"];
}


@end