// GPL

#import "AppDelegate.h"
#import "MainViewController.h"
#import "TickerViewController.h"


@implementation AppDelegate


@synthesize window;
@synthesize mainView;


-(void)applicationDidFinishLaunching:(UIApplication *)application {
    //[application setStatusBarOrientation:UIInterfaceOrientationLandscapeRight];
	//[window addSubview:[mainView view]];
    
    [window setRootViewController:mainView];
	[window makeKeyAndVisible];
}


-(void)applicationWillTerminate:(UIApplication *)application {
}


-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	NSLog(@"registered: %@", devToken);
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", devToken] forKey:@"Account.DeviceToken"];
}


-(void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	NSLog(@"remoteNotification: %@", userInfo);
	NSString *ticker = [userInfo objectForKey:@"ticker"];
	if ([ticker length] > 0) {
		[[mainView tickerView] enqueueMessage:ticker withType:nil];
	}
}


-(void)dealloc {
	[mainView release];
	[window release];
  [super dealloc];
}


@end