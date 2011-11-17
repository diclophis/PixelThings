// GPL


#import "Parse/Parse.h"
#import "ParseObject.h"
#import "ItemCategory.h"
#import "Item.h"
#import "FunItem.h"
#import "OperationsManager.h"
#import "StoreItemsViewController.h"



@implementation StoreItemsViewController


@synthesize items;
@synthesize tableView;
@synthesize activityView;
@synthesize refreshButton;
@synthesize descriptionLabel;
@synthesize backButton;
@synthesize category;
@synthesize isDismissed;
@synthesize selectedItem;


-(id)initWithCategory:(ItemCategory *)theCategory {
	if ((self = [super initWithNibName:@"StoreItemsViewController" bundle:[NSBundle mainBundle]])) {
		[self setCategory:theCategory];
		
		//BACK BUTTON
		[self setBackButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[backButton setAdjustsImageWhenHighlighted:YES];
		[backButton setImage:[UIImage imageNamed:@"ui_forumback.png"] forState:UIControlStateNormal];
		[backButton setFrame:CGRectMake(5.0f, 5.0f, 30.0f, 30.0f)];
		[backButton setTitle:@"B" forState:UIControlStateNormal];
		[backButton addTarget:self action:@selector(didClickBack:) forControlEvents:UIControlEventTouchUpInside];
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton setFrame:CGRectMake(445.0, 5.0, 30.0, 30.0)];
		[refreshButton addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
		
		//DESCRIPTION LABEL
		UILabel *theDescriptionLabel = [[UILabel alloc] init];
		[self setDescriptionLabel:theDescriptionLabel];
		[theDescriptionLabel release];
		[descriptionLabel setFrame:CGRectMake(40.0f, 5.0f, 400.0f, 30.0f)];
		[descriptionLabel setText:[category categoryDescription]];
		[descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[descriptionLabel setTextColor:[UIColor whiteColor]];
		
		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 5.0f, 30.0f, 30.0f)];
		
		[[OperationsManager sharedInstance] setStoreItemsDelegate:self];
	}
	return self;
}


-(void)dealloc {
	[tableView release];
	[activityView release];
	[refreshButton release];
	[descriptionLabel release];
	[backButton release];
	[category release];
	[selectedItem release];
	[items release];
	[super dealloc];
}


-(void)viewDidLoad {
	[super viewDidLoad];
	
	UIView *theHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theHeaderView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableHeaderView:theHeaderView];
	[theHeaderView release];
	
	[[tableView tableHeaderView] addSubview:backButton];
	[[tableView tableHeaderView] addSubview:descriptionLabel];
	[[tableView tableHeaderView] addSubview:refreshButton];
	
	UIView *theFooterView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 480.0f, 40.0f)];
	[theFooterView setBackgroundColor:[UIColor clearColor]];
	[tableView setTableFooterView:theFooterView];
	[theFooterView release];
	
	[[tableView tableFooterView] addSubview:activityView];
	
	[activityView startAnimating];
}


-(void)viewWillAppear:(BOOL)animated {
	[refreshButton setHidden:YES];
	[[OperationsManager sharedInstance] fetchItemsForCategory:[category uid]];
}


-(void)viewWillDisappear:(BOOL)animated {
	[tableView setDataSource:nil];
	[tableView setDelegate:nil];
	[tableView scrollRectToVisible:CGRectMake(0.0, 0.0, 1.0, 1.0) animated:NO];
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	[[OperationsManager sharedInstance] setStoreItemsDelegate:nil];
	[super viewWillDisappear:animated];
}


-(UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"storeItemCell"];
	Item *item;
	UILabel *titleLabel, *costLabel, *quantityLabel;
	
	if (cell == nil) {

		CGRect frame = CGRectMake(0, 0, 480, itemHeight + 10.0f);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"storeItemCell"] autorelease];
		[cell setOpaque:YES];
		
		item = [[[Item alloc] initWithFrame:CGRectMake(5.0f, 5.0f, itemWidth, itemHeight)] autorelease];
		[item setTag:1];
		[[cell contentView] addSubview:item];
		
		titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(100.0f, 5.0f, 285.0f, 60.0f)] autorelease];
		[titleLabel setAdjustsFontSizeToFitWidth:YES];
		[titleLabel setMinimumFontSize:8.0f];
		[titleLabel setTag:2];
		[titleLabel setBackgroundColor:[UIColor clearColor]];
		[titleLabel setTextColor:[UIColor blackColor]];
		[[cell contentView] addSubview:titleLabel];
		
		costLabel = [[[UILabel alloc] initWithFrame:CGRectMake(290.0f, 5.0f, 90.0f, 60.0f)] autorelease];
		[costLabel setAdjustsFontSizeToFitWidth:YES];
		[costLabel setMinimumFontSize:8.0f];
		[costLabel setTag:3];
		[costLabel setBackgroundColor:[UIColor clearColor]];
		[costLabel setTextColor:[UIColor blackColor]];
		[[cell contentView] addSubview:costLabel];
		
		quantityLabel = [[[UILabel alloc] initWithFrame:CGRectMake(395.0f, 5.0f, 80.0f, 60.0f)] autorelease];
		[quantityLabel setTag:4];
		[quantityLabel setBackgroundColor:[UIColor clearColor]];
		[quantityLabel setTextColor:[UIColor blackColor]];
		[[cell contentView] addSubview:quantityLabel];
	} else {
		//item = (Item *)[cell.contentView viewWithTag:1];
	}
	
	return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
	UILabel *titleLabel, *costLabel, *quantityLabel;

	Item *item = (Item *)[[cell contentView] viewWithTag:1];
	FunItem *funItem = [items objectAtIndex:[indexPath row]];
  //TODO
	[item setItemId:[funItem uid] andFilename:[NSString stringWithFormat:@"%@", [funItem uid]] andVariations:1 andFrames:1 andConstrained:NO andCurrentVariation:0];
	
	titleLabel = (UILabel *)[[cell contentView] viewWithTag:2];
	costLabel = (UILabel *)[[cell contentView] viewWithTag:3];
	quantityLabel = (UILabel *)[[cell contentView] viewWithTag:4];
	
	[titleLabel setText:[funItem name]];
	[costLabel setText:[NSString stringWithFormat:@"%d", [funItem costInPoints]]];
	[quantityLabel setText:[NSString stringWithFormat:@"%d", [funItem quantityAvailable]]];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [items count];
}



-(CGFloat)tableView:(UITableView *)theTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return itemHeight + 10.0f;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self setSelectedItem:[items objectAtIndex:[indexPath row]]];
	UIAlertView *theAlert = [[[UIAlertView alloc] initWithTitle:@"Purchase?" message:@"Are you sure you want to buy this?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil] autorelease];
	[theAlert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[[OperationsManager sharedInstance] purchaseItem:selectedItem];
	} else {
		[self refresh:nil];
	}
}


-(void)didFetchItems:(NSArray *)theItems {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
	[self setItems:theItems];
	[[self tableView] reloadData];
}


-(void)didNotFetchItems {
	[activityView stopAnimating];
	[refreshButton setHidden:NO];
}


-(void)didPurchaseItem:(FunItem *)theItem {
	[self refresh:nil];
}


-(void)didNotPurchaseItem {
	[self refresh:nil];
}


-(void)refresh:(id)sender {
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[self setItems:[[NSArray alloc] init]];
	[[self tableView] reloadData];
	[[OperationsManager sharedInstance] fetchItemsForCategory:[category uid]];
}


-(void)didClickBack:(id)sender {
	[self setIsDismissed:YES];
}


@end