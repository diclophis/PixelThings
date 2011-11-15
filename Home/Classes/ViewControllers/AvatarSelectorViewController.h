// GPL

#import <UIKit/UIKit.h>


@class PickerBase;


@interface AvatarSelectorViewController : UIViewController {
	PickerBase *activePicker;
	int selectedPicker;
	NSString *navigateAction;
}


@property (nonatomic, retain) PickerBase *activePicker;
@property (nonatomic, retain) NSString *navigateAction;


-(void)toggleBodyClothes;


@end