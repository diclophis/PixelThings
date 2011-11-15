// GPL

#import <UIKit/UIKit.h>


@interface TickerViewController : UIViewController {
	NSString *selectedAction;
	NSMutableArray *reports;
	NSMutableArray *messages;
}


@property (retain) NSString *selectedAction;
@property (retain) NSMutableArray *reports;
@property (retain) NSMutableArray *messages;


-(void)scrollStopped:(NSString *)animationID finished:(BOOL)finished context:(void *)contex;
-(void)enqueueMessage:(NSString *)theMessage withType:(NSString *)theType;
-(void)didClickInfo:(id)sender;


@end
