// GPL

#import <UIKit/UIKit.h>


@interface ClickableView : UIView {
	id target;
	SEL singleClickAction;
	SEL doubleClickAction;
	SEL dragAction;
	CGPoint startLocation;
}

@property (nonatomic, retain) id target;
@property (nonatomic) SEL singleClickAction;
@property (nonatomic) SEL doubleClickAction;
@property (nonatomic) SEL dragAction;

-(void)handleSingleClick;
-(BOOL)isHandled:(NSSet *)touches;

@end
