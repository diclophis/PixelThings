#import "InfoViewController.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"

@implementation InfoViewController


-(id)init {
	if ((self = [super initWithNibName:@"InfoViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;	
}


-(void)viewDidLoad {
	[super viewDidLoad];
	[scrollView setContentSize:CGSizeMake(480.0f, 824.0f)];
	[scrollView setScrollEnabled:YES];
}


-(IBAction)didClickBack:(id)sender {
	[self setSelectedAction:@"CloseInfo"];
}


@end
