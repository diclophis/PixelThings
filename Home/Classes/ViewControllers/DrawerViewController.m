// GPL

#import "DrawerViewController.h"


@implementation DrawerViewController


-(void)viewDidLoad {
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];	
}


-(void)viewWillAppear:(BOOL)animated {
	[self disable];
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
}


-(void)viewWillDisappear:(BOOL)animated {
	[self disable];
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 320.0f)];
}


@end
