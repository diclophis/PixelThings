// GPL

#import <Foundation/Foundation.h>


@interface MenuViewController : UIViewController {
	BOOL expanded;
	BOOL moving;
	NSString *selectedAction;
}


@property BOOL expanded;
@property BOOL moving;
@property (retain) NSString *selectedAction;


-(void)toggle;
-(void)disable;
-(void)enable;


@end


