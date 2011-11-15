// GPL

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PickerBase : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate> {
	UIPickerView *picker;
	id toggleTarget;
	SEL toggleAction;
	NSMutableArray *pickerColumnValues;
	NSMutableArray *ownedFlags;
	BOOL isShowing;
}

@property (nonatomic, retain) IBOutlet UIPickerView *picker;
@property (nonatomic, retain) id toggleTarget;
@property (nonatomic) SEL toggleAction;
@property (nonatomic, retain) NSMutableArray *pickerColumnValues;
@property (nonatomic, retain) NSMutableArray *ownedFlags;
@property (nonatomic) BOOL isShowing;

-(id)initWithNibName:(NSString *)theNibName;
-(IBAction)toggle:(id)sender;
-(NSString *)getAvatarPieceNameForColumn:(NSInteger)column;
-(void)postChangeSkeletonPieceNotificationForPickerColumn:(NSInteger)theColumn;
-(NSArray *)getAvatarPiecesForColumn:(NSInteger)pickerColumn;
-(NSArray *)getInventoryAvatarPiecesForColumn:(NSInteger)pickerColumn;
-(NSString *)getAvatarPieceNameForColumn:(NSInteger)pickerColumn;
-(void)setOwnedFlagAtColumn:(NSInteger)theColumn andRow:(NSInteger)theRow andOwned:(BOOL)theOwned;
-(BOOL)getOwnedFlagAtColumn:(NSInteger)theColumn andRow:(NSInteger)theRow;
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView;
-(NSString *)getAvatarPieceNameForColumn:(NSInteger)pickerColumn;
-(void)handleIsShowingNotification:(NSNotification *)theNotification;

@end
