// GPL

#import <UIKit/UIKit.h>


@class MainViewController;


@interface AppDelegate : NSObject <UIApplicationDelegate> {
  UIWindow *window;
	IBOutlet MainViewController *mainView;
}


@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainView;


@end

