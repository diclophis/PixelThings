// GPL

#import "AvatarSelectorViewController.h"
#import "PickerBody.h"
#import "PickerClothes.h"


@implementation AvatarSelectorViewController

#define BODY 0
#define CLOTHES 1
#define UNINITIALIZED -1

@synthesize activePicker;
@synthesize navigateAction;


-(void)dealloc {
	[self setNavigateAction:nil];
	[self setActivePicker:nil];
    [super dealloc];
}


-(id)init {
	if ((self = [super initWithNibName:@"AvatarSelectorViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[activePicker viewWillDisappear:animated];
	[super viewWillDisappear:animated];
}


-(void)viewWillAppear:(BOOL)animated {
	selectedPicker = UNINITIALIZED;
	[self setActivePicker:nil];
	[self toggleBodyClothes];
	[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(toggleBodyClothes) name:@"avatarSelector" object: nil];
}


-(void)toggleBodyClothes
{
	if (activePicker)
	{
		[activePicker viewWillDisappear:NO];
		[[activePicker view] removeFromSuperview];
		[activePicker release];
	}

	if (selectedPicker == CLOTHES || selectedPicker == UNINITIALIZED)
	{
		activePicker = [[PickerBody alloc] init];
		selectedPicker = BODY;
	}
	else
	{
		activePicker = [[PickerClothes alloc] init];
		selectedPicker = CLOTHES;
	}
	
	[[self view] addSubview:[activePicker view]];
	[activePicker setToggleTarget:self];
	[activePicker setToggleAction:@selector(toggleBodyClothes)];
}




@end