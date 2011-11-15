#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface StartViewController : UIViewController{
	IBOutlet UIImageView *introImageView;

}

@property (retain) UIImageView *introImageView;


-(IBAction)didClickClose:(id)sender;


@end
