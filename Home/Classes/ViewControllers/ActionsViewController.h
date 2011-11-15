// GPL


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>


@class AnimatedPerson;
@class AnimatedObject;


@interface ActionsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
	int changeMeSection;
	int actionsSection;	
	AnimatedPerson *animatedPerson;
}


@property (nonatomic, retain) AnimatedPerson *animatedPerson;


-(ActionsViewController *)initWithAnimatedPerson:(AnimatedPerson *)thePerson;
-(IBAction)didClickClose:(id)sender;


@end