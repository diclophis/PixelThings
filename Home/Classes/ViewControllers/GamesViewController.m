// GPL

#import "GamesViewController.h"
//#import "protocol.h"
#import "OperationsManager.h"


@implementation GamesViewController


@synthesize extrasTableView;
@synthesize externalApps;

-(void)dealloc
{
	[externalApps release];
	[self setExtrasTableView:nil];
	[super dealloc];
}


-(id)init {
	if ((self = [super initWithNibName:@"GamesViewController" bundle:[NSBundle mainBundle]])) {
		[[OperationsManager sharedInstance] setExternalAppsDelegate:self];
	}
	return self;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[[OperationsManager sharedInstance] fetchExternalApps];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[OperationsManager sharedInstance] setExternalAppsDelegate:nil];
	[super viewWillDisappear:animated];
}

-(void)didFetchExternalApps:(NSMutableArray *)theExternalApps {
	[self setExternalApps:theExternalApps];
	[extrasTableView reloadData];
}


-(void)didNotFetchExternalApps {
}


- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [externalApps count];
}


- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"gamesMenuCell"];
	UILabel *title, *longDescription;
	UIImageView *icon;
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 400, 30);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"gamesMenuCell"] autorelease];
		
		icon = [[[UIImageView alloc] initWithFrame:CGRectMake(5.0f, 5.0f, 60.0f, 30.0f)] autorelease];
		icon.tag = 1;
		[cell.contentView addSubview:icon];
		
		
		title = [[[UILabel alloc] initWithFrame:CGRectMake(75.0, 5.0, 150, 30.0)] autorelease];
		[title setBackgroundColor:[UIColor clearColor]];
		title.tag = 2;
		title.font = [UIFont boldSystemFontOfSize:14.0];
		title.textAlignment = UITextAlignmentLeft;
		title.textColor = [UIColor whiteColor];
		[cell.contentView addSubview:title];
		
		longDescription = [[[UILabel alloc] initWithFrame:CGRectMake(230.0, 5.0, 245, 30.0)] autorelease];
		[longDescription setBackgroundColor:[UIColor clearColor]];
		longDescription.tag = 3;
		longDescription.font = [UIFont systemFontOfSize:12.0];
		longDescription.textAlignment = UITextAlignmentLeft;
		longDescription.textColor = [UIColor whiteColor];
		[cell.contentView addSubview:longDescription];
		
	} else {
		//icon = (UIImageView *)[cell.contentView viewWithTag:1];
		//title = (UILabel *)[cell.contentView viewWithTag:2];
		//longDescription = (UILabel *)[cell.contentView viewWithTag:3];
	}
	

  /*
  UIImage *theImage;
  ExternalApp *theExternalApp = [externalApps objectAtIndex:[indexPath row]];
  theImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[theExternalApp iconFilename] ofType:@"png"]];
  [icon setImage:theImage];
  [title setText:[theExternalApp name]];
  [longDescription setText:[theExternalApp longDescription]];
	*/
  
	return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  /*
  ExternalApp *theExternalApp = [externalApps objectAtIndex:[indexPath row]];
  
  NSURL *url;
  
  if ([theExternalApp isInstalled]) {
    url = [NSURL URLWithString:[theExternalApp customUrl]];
    BOOL opened = [[UIApplication sharedApplication] openURL:url];
    if (!opened) {
      url = [NSURL URLWithString:[theExternalApp itunesUrl]];
      [[UIApplication sharedApplication] openURL:url];
    }
  } else {
    url = [NSURL URLWithString:[theExternalApp itunesUrl]];
    [[UIApplication sharedApplication] openURL:url];
  }
  */

}


-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"Main"];
}


@end