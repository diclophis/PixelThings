#import "ForumRulesViewController.h"
#import "OperationsManager.h"
#import "NSStringAdditions.h"


@implementation ForumRulesViewController


-(id)init {
	if ((self = [super initWithNibName:@"ForumRulesViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}

-(IBAction)didClickBack:(id)sender {
	[self setSelectedAction:@"CloseForumRules"];
}



@end
