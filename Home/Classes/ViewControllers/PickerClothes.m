// GPL


#import "PickerClothes.h"


@implementation PickerClothes

-(id)init {
	if ((self = [super initWithNibName:@"PickerClothes"])) {
		//
	}
	return self;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 3;
}

-(NSString *)getAvatarPieceNameForColumn:(NSInteger)pickerColumn
{
	NSString *result = nil;
	switch (pickerColumn) {
		case 0:
			result =@"hairul";
			break;
		case 1:
			result =@"shirt";
			break;
		case 2:
			result =@"pants";
			break;
		default:
			break;
	}
	return result;
}

-(IBAction)share
{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"navigate" object:nil userInfo:[NSDictionary dictionaryWithObject:@"share" forKey:@"target"]];
}
	
-(IBAction)showBody
{
}

@end
