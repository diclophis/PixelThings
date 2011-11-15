#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "DrawerViewController.h"


@interface InfoViewController : DrawerViewController {
	IBOutlet UIScrollView *scrollView;
}


-(IBAction)didClickBack:(id)sender;


@end
