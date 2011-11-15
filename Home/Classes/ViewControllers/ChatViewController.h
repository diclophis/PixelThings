// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"


@interface ChatViewController : DrawerViewController <UIWebViewDelegate, UITextFieldDelegate> {
	UIWebView *myWebView;
	UITextField *myMessageField;
	BOOL bumped;
}


@property (retain) IBOutlet UIWebView *myWebView;
@property (retain) IBOutlet UITextField *myMessageField;
@property (nonatomic) BOOL bumped;


-(IBAction)didClickBack:(id)sender;
-(void)bumpUp;
-(void)bumpDown;


@end
