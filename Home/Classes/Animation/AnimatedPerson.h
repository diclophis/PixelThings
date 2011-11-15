// GPL

#import <Foundation/Foundation.h>
#import "AnimatedObject.h"
#import "StatusBubble.h"
#import "ActionsViewController.h"

@class MainMenuViewController;

@interface AnimatedPerson : NSObject {
	AnimatedObject *character;
	NSString *eyebrows;
	NSString *eyes;
	NSString *mouth;
	NSString *body;
	NSString *hair;
	NSString *shirt;
	NSString *pants;
	NSString *currentLoop;
	NSString *selectedAction;
	UIView *view;
	NSString *status;
	StatusBubble *statusBubble;
	int currentAnimationStep;
	NSArray *currentAnimationSequence;
	BOOL enableInteractions;
	BOOL isFlipped;
	ActionsViewController *actionsMenu;
	BOOL enableChangeMe;
	BOOL enableAnimations;
	NSArray *animations;
	NSString *singleClickAction;
	NSInteger mySimpleType;
}

-(id)initWithEyebrows:(NSString *)theEyebrows
				  andEyes:(NSString *)theEyes
				 andMouth:(NSString *)theMouth
				  andBody:(NSString *)theBody
				  andHair:(NSString *)theHair
				 andShirt:(NSString *)theShirt
				 andPants:(NSString *)thePants
				andOrigin:(CGPoint)theOrigin andView:(UIView *)theView;
-(void)playLoop:(NSString *)theLoopName;
-(void)changeEyebrows:(NSString *)theEyebrows;
-(void)changeEyes:(NSString *)theEyes;
-(void)changeMouth:(NSString *)theMouth;
-(void)changeBody:(NSString *)theBody;
-(void)changeHair:(NSString *)theHair;
-(void)changeShirt:(NSString *)theShirt;
-(void)changePants:(NSString *)thePants;
-(void)restartAnimation;
-(void)updateStatus:(NSString *)theStatus;
-(void)setStatusBubbleHidden:(BOOL)hidden;
-(void)handleStatusBubbleClicked;
-(void)doChangeMe;
-(void)handleSingleClick;
-(void)showAnimationMenu;
-(void)hideActionsMenu;
-(void)playAnimation:(NSString *)animationName;
-(void)finishSequence;
-(void)playNextStepInSequence;
-(void)setHidden:(BOOL)hidden;

+(AnimatedPerson *)loadCharacterWithEyebrows:(NSString *)theEyebrows
									 andEyes:(NSString *)theEyes
									andMouth:(NSString *)theMouth
									 andBody:(NSString *)theBody
									 andHair:(NSString *)theHair
									andShirt:(NSString *)theShirt
									andPants:(NSString *)thePants
									intoView:(UIView *)theView
								   belowView:(UIView *)theBelowView
								 andObserver:(id)theObserver
								   andOrigin:(CGPoint)theOrigin
						   andEnableChangeMe:(BOOL)theEnableChangeMe
						 andEnableAnimations:(BOOL)theEnableAnimations
							   andAnimations:(NSArray *)theAnimations;

@property (nonatomic, retain) AnimatedObject *character;
@property (nonatomic, retain) NSString *eyebrows;
@property (nonatomic, retain) NSString *eyes;
@property (nonatomic, retain) NSString *mouth;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *hair;
@property (nonatomic, retain) NSString *shirt;
@property (nonatomic, retain) NSString *pants;
@property (nonatomic, retain) NSString *currentLoop;
@property (nonatomic, retain) NSString *selectedAction;
@property (nonatomic, retain) UIView *view;
@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) StatusBubble *statusBubble;
@property (nonatomic) BOOL enableInteractions;
@property (nonatomic) BOOL enableChangeMe;
@property (nonatomic) BOOL enableAnimations;
@property (nonatomic, retain) NSArray *currentAnimationSequence;
@property (nonatomic, retain) ActionsViewController *actionsMenu;
@property (nonatomic, retain) NSArray *animations;
@property (nonatomic, retain) NSString *singleClickAction;
@property NSInteger mySimpleType;


-(void)handleNavigateNotification:(NSNotification *)theNotification;


@end
