// GPL


#import "PickerBase.h"
#import "AnimationSystem.h"


@implementation PickerBase


@synthesize picker;
@synthesize toggleTarget;
@synthesize toggleAction;
@synthesize pickerColumnValues;
@synthesize ownedFlags;
@synthesize isShowing;

#define CHECK_INVENTORY NO

-(id)initWithNibName:(NSString *)theNibName {
	if ((self = [super initWithNibName:theNibName bundle:[NSBundle mainBundle]])) {
		[self setPickerColumnValues:[NSMutableArray array]];
		[self setOwnedFlags:[NSMutableArray array]];
		[self setIsShowing:YES];
		[[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(handleIsShowingNotification:) name:@"tabViewController" object: nil];
	}
	return self;
}


-(void)dealloc
{
	[picker release];
	[pickerColumnValues release];
	[ownedFlags release];
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[super dealloc];
}



-(IBAction)toggle:(id)sender
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"avatarSelector" object:nil userInfo:nil];
}	

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 0;
}

-(NSString *)getAvatarPieceNameForColumn:(NSInteger)pickerColumn
{
	return nil;
}


-(NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
	NSArray *list = [pickerColumnValues objectAtIndex:component];
	return [list count];
}

-(NSArray *)getAvatarPiecesForColumn:(NSInteger)pickerColumn
{
	
	NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
	NSString *pieceName = [self getAvatarPieceNameForColumn:pickerColumn];
	NSArray *pieceList = [defs objectForKey:pieceName];
	return pieceList;
}

-(NSArray *)getInventoryAvatarPiecesForColumn:(NSInteger)pickerColumn
{
	assert(NO);
}

- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
	UILabel *pickerLabel;
	
	// Reuse the label if possible, otherwise create and configure a new one
	if ((view == nil) /*|| ([pickerLabel class] != [UILabel class])*/) {  //newlabel
		
		CGRect frame = CGRectMake(60.0, 0.0, 60, 20);

		view = [[[UIView alloc] initWithFrame:frame] autorelease];
		pickerLabel = [[[UILabel alloc] initWithFrame:frame] autorelease];
		pickerLabel.textAlignment = UITextAlignmentLeft;
		pickerLabel.backgroundColor = [UIColor clearColor];
		pickerLabel.font = [UIFont fontWithName:@"Marker Felt" size:18];
		pickerLabel.text = @"";
		[view addSubview:pickerLabel];
	}
	
	pickerLabel = [[view subviews] objectAtIndex:0];
	NSArray *list = [pickerColumnValues objectAtIndex:component];
	pickerLabel.text = [list objectAtIndex:row];
	pickerLabel.frame = CGRectMake(0, 0, 60, 20);	
	BOOL isChecked = [self getOwnedFlagAtColumn:component andRow:row];
	if (isChecked)
	{
		if ([[view subviews] count] == 1)
		{
			UIImageView *checkBox = [[[UIImageView alloc] init] autorelease];
			UIImage *img = [[AnimationSystem instance] checkBoxImage];
			[checkBox setImage:img];
			
			CGRect frame = [checkBox frame];
			frame.origin.x = 40;
			frame.size = [img size];
			[checkBox setFrame:frame];
			[view addSubview:checkBox];
		}
	}
	else
	{
		if ([[view subviews] count] == 2)
		{
			[[[view subviews] objectAtIndex:1] removeFromSuperview];
		}
	}
	return view;
}

-(void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	for (int i = 0; i < [picker numberOfComponents]; i++)
	{
		[self postChangeSkeletonPieceNotificationForPickerColumn:i];
	}
}

-(void)postChangeSkeletonPieceNotificationForPickerColumn:(NSInteger)theColumn
{
	NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
	[userInfo setValue:@"changeSkeletonPiece" forKey:@"action"];
	[userInfo setValue:[self getAvatarPieceNameForColumn:theColumn] forKey:@"piece"];
	NSArray *pieces = [self getAvatarPiecesForColumn:theColumn];
	[userInfo setValue:[pieces objectAtIndex:[picker selectedRowInComponent:theColumn]] forKey:@"value"];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"avatar" object:nil userInfo:userInfo];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)viewDidLoad {
  [super viewDidLoad];
	int columns = [self numberOfComponentsInPickerView:nil];
	for (int i = 0; i < columns; i++)
	{
		NSArray *pieces = [self getAvatarPiecesForColumn:i];
		[pickerColumnValues addObject:pieces];
		NSMutableArray *columnOwnedFlags = [NSMutableArray arrayWithCapacity:[pieces count]];
		[ownedFlags addObject:columnOwnedFlags];
		for (int row = 0; row < [pieces count]; row++)
		{
			[columnOwnedFlags addObject:[NSNumber numberWithBool:NO]];
		}
    //NSLog(@"DEAD CODE!!!");
    //assert(NO);
    /*
		if ([LoginHelper isLoggedIn] && CHECK_INVENTORY)
		{
			NSArray *ownedPieces = [self getInventoryAvatarPiecesForColumn:i];
			for (NSString *ownedPiece in ownedPieces)
			{
				for (int row = 0; row < [pieces count]; row++)
				{
					NSString *piece = [pieces objectAtIndex:row];
					if ([piece isEqualToString:ownedPiece])
					{
						[self setOwnedFlagAtColumn:i andRow:row andOwned:YES];
						break;
					}
				}
			}
		}
    */
	}
	for (int i = 0; i < [self numberOfComponentsInPickerView:nil]; i++)
	{
		NSString *pieceName = [self getAvatarPieceNameForColumn:i];
		NSArray *pieces = [[NSUserDefaults standardUserDefaults] objectForKey:pieceName];
		int selectedPieceIndex = [pieces indexOfObject:[[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"def%@", pieceName]]];
		[picker selectRow:selectedPieceIndex inComponent:i animated:NO];
	}
	[[AnimationSystem instance] addObserver:self forKeyPath:@"shakeDetected" options:NSKeyValueObservingOptionNew context:nil];	

}

-(void)setOwnedFlagAtColumn:(NSInteger)theColumn andRow:(NSInteger)theRow andOwned:(BOOL)theOwned
{
	NSMutableArray *pieces = [ownedFlags objectAtIndex:theColumn];
	[pieces replaceObjectAtIndex:theRow withObject:[NSNumber numberWithBool:theOwned]];
}

-(BOOL)getOwnedFlagAtColumn:(NSInteger)theColumn andRow:(NSInteger)theRow
{
	return [[[ownedFlags objectAtIndex:theColumn] objectAtIndex:theRow] boolValue];
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (isShowing)
	{
		for (int i = 0; i < [self numberOfComponentsInPickerView:picker]; i++)
		{
			int selected = random() % [[self getAvatarPiecesForColumn:i] count];
			[picker selectRow:selected inComponent:i animated:NO];
			[self pickerView:picker didSelectRow:selected inComponent:i];
		}
	}
}


-(void)viewWillDisappear:(BOOL)animated {
	if (toggleTarget) {
		[[AnimationSystem instance] removeObserver:self forKeyPath:@"shakeDetected"];
		[toggleTarget release];
		toggleTarget = nil;
	}
	[super viewWillDisappear:animated];
}

-(void)handleIsShowingNotification:(NSNotification *)theNotification
{
	isShowing = [[[theNotification userInfo] objectForKey:@"isShowing"] boolValue];
	[self setIsShowing:isShowing];
}

@end
