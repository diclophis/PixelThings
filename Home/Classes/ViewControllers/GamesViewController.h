// GPL

#import <Foundation/Foundation.h>
#import "DrawerViewController.h"
#import "OperationsManager.h"


@interface GamesViewController : DrawerViewController <UITableViewDataSource, UITableViewDelegate, ExternalAppsDelegate> {
	UITableView *extrasTableView;
	NSMutableArray *externalApps;
}


@property (retain) IBOutlet UITableView *extrasTableView;
@property (retain) NSMutableArray *externalApps;


-(IBAction)didClickClose:(id)sender;


@end
