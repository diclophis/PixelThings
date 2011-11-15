// GPL

#import <Foundation/Foundation.h>
#import "ClickableView.h"

@interface StatusBubble : UIView {
	UIImageView *bubble;
	UILabel *text;
	ClickableView *clickableView;
}

@property (nonatomic, retain) UIImageView *bubble;
@property (nonatomic, retain) UILabel *text;
@property (nonatomic, retain) ClickableView *clickableView;

-(StatusBubble *)initWithOrigin:(CGPoint)theOrigin andTarget:(id)theTarget andClickAction:(SEL)theClickAction;
-(void)setStatus:(NSString *)theStatus;

@end
