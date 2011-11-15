// GPL

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ClickableView.h"

@interface AnimatedObject : UIView {
	NSString *skeletonName;
	NSMutableDictionary *charactersForSkeletonPieces;
	NSString *currentAnimationName;
	NSMutableArray *animatedImageViews;
	NSString *defaultAnimation;
	ClickableView *clickableView;
}

-(id)initWithSkeleton:(NSString *)theSkeletonName andCharactersForSkeletonPieces:(NSArray *)theCharactersForSkeletonPieces andOrigin:(CGPoint)theOrigin andDefaultAnimation:(NSString *)theDefaultAnimation;
-(void)playLoop:(NSString *)theLoop andRepeatCount:(int)theRepeatCount;
-(void)moveWithDx:(int)theDx andDy:(int)theDy andDuration:(int)theDuration andSx:(CGFloat)sx andSy:(CGFloat)sy;
-(UIImageView *)loadDefaultImageForSkeletonPiece:(NSString *)skeletonPiece;
-(int)getSkeletonParameter:(NSString *)theParameterName;
-(void)stopAnimating;
-(NSArray *)getSkeletonPieces;
-(void)changeSelectedCharacter:(NSString *)theCharacter forSkeletonPiece:(NSString *)theSkeletonPiece;

@property (nonatomic, retain) NSString *skeletonName;
@property (nonatomic, retain) NSMutableDictionary *charactersForSkeletonPieces;
@property (nonatomic, retain) NSMutableArray *animatedImageViews;
@property (nonatomic, retain) NSString *defaultAnimation;
@property (nonatomic, retain) NSString *currentAnimationName;
@property (nonatomic, retain) ClickableView *clickableView;

-(void)setClickTarget:(id)target;
-(void)setSingleClickAction:(SEL)singleClickAction;
-(void)setDoubleClickAction:(SEL)doubleClickAction;

@end
