// GPL

#import <Foundation/Foundation.h>


@interface RoomViewController : UIViewController {
	CGFloat offsetX;
	CGFloat offsetY;
	BOOL editing;
	UIButton *removeButton;
	Item *itemToRemove;
	NSMutableArray *items;
	Item *currentBackground;
}


@property BOOL editing;
@property (nonatomic, retain) UIButton *removeButton;
@property (nonatomic, retain) Item *itemToRemove;
@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) Item *currentBackground;


-(void)removeItem:(id)sender;
-(void)hideRemoveButton:(id)sender;
-(void)addItem:(Item *)theItem;
-(void)reset;


@end