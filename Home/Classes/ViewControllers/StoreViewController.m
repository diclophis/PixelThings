// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "Item.h"
#import "ItemCategory.h"
#import "StoreItemsViewController.h"
#import "StoreViewController.h"


@implementation StoreViewController


@synthesize storeItemsView;
@synthesize categories;
@synthesize activityView;
@synthesize titleLabel;
@synthesize refreshButton;
@synthesize tableView;


-(id)init {
	if ((self = [super initWithNibName:@"StoreViewController" bundle:[NSBundle mainBundle]])) {
		[[OperationsManager sharedInstance] setStoreDelegate:self];
		[self setSelectedAction:@"TODO"];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		
		
		//TITLE
		UILabel *theTitleLabel = [[UILabel alloc] init];
		[self setTitleLabel:theTitleLabel];
		[theTitleLabel release];
		[titleLabel setFrame:CGRectMake(5.0f, 5.0f, 360.0f, 30.0f)];
		//TODO
		[titleLabel setText:@""];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor blackColor]];
		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
		
	}
	return self;
}


-(void)dealloc {
	[refreshButton release];
	[activityView release];
	[titleLabel release];
	[storeItemsView release];
	[categories release];
	[tableView release];
	[super dealloc];
}


-(void)viewDidLoad {
	[super viewDidLoad];

	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:refreshButton];
	[[tableView tableHeaderView] addSubview:titleLabel];
	
	UIView *theFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theFooterView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableFooterView:theFooterView];
	[theFooterView release];
	
	[[tableView tableFooterView] addSubview:activityView];
	[activityView startAnimating];
}



-(void)viewWillAppear:(BOOL)animated {
	[refreshButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchStoreCategories];
	[super viewWillAppear:animated];
}


-(void)viewWillDisappear:(BOOL)animated {
	[tableView scrollRectToVisible:CGRectMake(0.0, 0.0, 1.0, 1.0) animated:NO];
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	[[OperationsManager sharedInstance] setStoreDelegate:nil];
	[super viewWillDisappear:animated];
}


-(void)didFetchCategories:(NSArray *)theCategories {
	[refreshButton setHidden:NO];
	[activityView stopAnimating];
	[self setCategories:theCategories];
	[tableView reloadData];
}


-(void)didNotFetchCategories {
	[refreshButton setHidden:NO];
	[activityView stopAnimating];
}


-(IBAction)didClickClose:(id)sender {
	[self setSelectedAction:@"Main"];
}


-(void)refresh:(id)sender {
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[self setCategories:nil];
	[tableView reloadData];
	[[OperationsManager sharedInstance] fetchStoreCategories];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {	
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"storeCategoryCell"];
	UILabel *title; //, *description;
	Item *item;
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 480, 50);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"storeCategoryCell"] autorelease];
		
		item = [[[Item alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 75.0, 75.0)] autorelease];
		[item setTag:1];
		[[cell contentView] addSubview:item];
		
		title = [[[UILabel alloc] initWithFrame:CGRectMake(100.0, 5.0, 480.0 - 100.0 - 20.0, 65.0)] autorelease];
		[title setBackgroundColor:[UIColor clearColor]];
		title.tag = 2;
		//title.font = [UIFont boldSystemFontOfSize:14.0];
		//title.textAlignment = UITextAlignmentLeft;
		//title.textColor = [UIColor whiteColor];
		[cell.contentView addSubview:title];
		
		//description = [[[UILabel alloc] initWithFrame:CGRectMake(200.0, 0.0, 280.0, 75.0)] autorelease];
		//[description setBackgroundColor:[UIColor clearColor]];
		//description.tag = 3;
		//description.font = [UIFont systemFontOfSize:13.0];
		//description.textAlignment = UITextAlignmentRight;
		//description.textColor = [UIColor whiteColor];
		
		//[cell.contentView addSubview:description];
	} else {
		//item = (Item *)[cell.contentView viewWithTag:1];
		title = (UILabel *)[cell.contentView viewWithTag:2];
	}
	
	ItemCategory *category = [categories objectAtIndex:[indexPath row]];
	[title setText:[category categoryDescription]];
	
	//[item setTransform:CGAffineTransformMakeScale(0.25, 0.25)];
	//[UIView beginAnimations:nil context:NULL];
	//[UIView setAnimationDuration:ANIMATION_DURATION * 2.0];
	//[item setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
	//[UIView commitAnimations];
	
	return cell;
}


-(void)tableView:(UITableView *)theTableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	Item *item = (Item *)[[cell contentView] viewWithTag:1];
	ItemCategory *category = [categories objectAtIndex:[indexPath row]];
  //TODO
	[item setItemId:[category uid] andFilename:[NSString stringWithFormat:@"%@", [category uid]] andVariations:1 andFrames:1 andConstrained:NO andCurrentVariation:0];
}


-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 75.0f;
}


-(NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section {
	return [categories count];
}


-(void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ItemCategory *category = [categories objectAtIndex:[indexPath row]];
	
	StoreItemsViewController *theStoreItemsView = [[StoreItemsViewController alloc] initWithCategory:category];
	[self setStoreItemsView:theStoreItemsView];
	[theStoreItemsView release];
	[storeItemsView addObserver:self forKeyPath:@"isDismissed" options:NSKeyValueObservingOptionNew context:nil];

	
	[storeItemsView viewWillAppear:YES];
	[[self view] addSubview:[storeItemsView view]];
	[[storeItemsView view] setFrame:CGRectOffset([theTableView frame], 480.0f, 0.0f)];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration:ANIMATION_DURATION];
	
	[[storeItemsView view] setFrame:[theTableView frame]];
	[theTableView setFrame:CGRectOffset([theTableView frame], -480.0f, 0.0f)];
	
	[UIView commitAnimations];

}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"isDismissed"]) {
		[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO];
		if ([object isKindOfClass:[StoreItemsViewController class]]) {
			[storeItemsView removeObserver:self forKeyPath:@"isDismissed"];
			[UIView beginAnimations:nil context:NULL];
			[UIView setAnimationDelegate:self];
			[UIView setAnimationDuration:ANIMATION_DURATION];
			[storeItemsView viewWillDisappear:YES];
			[[storeItemsView view] setFrame:CGRectOffset([[storeItemsView view] frame], 480.0f, 0.0f)];
			[tableView setFrame:CGRectOffset([tableView frame], 480.0f, 0.0f)];
			[UIView commitAnimations];
			[self setStoreItemsView:nil];
			[self refresh:nil];
		}
	}
}


@end