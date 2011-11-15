// GPL


#import "PickerBody.h"
#import "AnimationSystem.h"


@implementation PickerBody


-(id)init {
	if ((self = [super initWithNibName:@"PickerBody"])) {
		//
	}
	return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 4;
}

-(NSString *)getAvatarPieceNameForColumn:(NSInteger)pickerColumn
{
	NSString *result;
	switch (pickerColumn) {
		case 0:
			result = @"eb";
			break;
		case 1:
			result = @"eyes";
			break;
		case 2:
			result = @"mouth";
			break;
		case 3:
			result = @"body";
			break;
		default:
      result = @"";
			break;
	}
	return result;
}

-(IBAction)showClothes
{
}

@end
