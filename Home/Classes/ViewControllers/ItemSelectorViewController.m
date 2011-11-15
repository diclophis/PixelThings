// GPL


#import "Item.h"
#import "OperationsManager.h"
#import "ItemSelectorViewController.h"
#import "ItemSelectorScrollView.h"

@implementation ItemSelectorViewController


@synthesize items;
@synthesize scrollView;
@synthesize visibleItems;
@synthesize activeItem;	
@synthesize itemToDrop;
@synthesize activeCategoryKey;
@synthesize refreshButton;
@synthesize activityView;
@synthesize emptyItemsLabel;


-(void)dealloc {
	[refreshButton release];
	[activityView release];
	[emptyItemsLabel release];
	[scrollView release];
	[activeCategoryKey release];
	for (id i in items) {
		[i removeFromSuperview];
	}
	[items removeAllObjects];
	[items release];
	[visibleItems removeAllObjects];
	[visibleItems release];
	[activeItem release];
	[itemToDrop release];
	[super dealloc];
}

-(id)init {
	if ((self = [super initWithNibName:@"ItemSelectorViewController" bundle:[NSBundle mainBundle]])) {
		currentPage = 0.0f;
		[[OperationsManager sharedInstance] setRoomEditingDelegate:self];
		
		//TITLE
		UILabel *theEmptyItemsLabel = [[UILabel alloc] init];
		[self setEmptyItemsLabel:theEmptyItemsLabel];
		[theEmptyItemsLabel release];
		[emptyItemsLabel setFrame:CGRectMake(50.0f, 50.0f, 400.0f, 30.0f)];
		//TODO
		[emptyItemsLabel setText:@""];
		[emptyItemsLabel setBackgroundColor:[UIColor clearColor]];
		[emptyItemsLabel setTextColor:[UIColor whiteColor]];
		
		
		//REFRESH BUTTON
		[self setRefreshButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[refreshButton setAdjustsImageWhenHighlighted:YES];
		[refreshButton setImage:[UIImage imageNamed:@"ui_forumreload.png"] forState:UIControlStateNormal];
		[refreshButton addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
		[refreshButton setFrame:CGRectMake(225.0, 50.0, 30.0, 30.0)];

		
		//ACTIVITY
		UIActivityIndicatorView *theActivityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
		[self setActivityView:theActivityView];
		[theActivityView release];
		[activityView setFrame:CGRectMake(225.0f, 50.0f, 30.0f, 30.0f)];

	}
	return self;
}


-(void)viewDidLoad {
	[[self view] addSubview:activityView];
	[[self view] addSubview:refreshButton];
	[[self view] addSubview:emptyItemsLabel];
	[super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated {	
	currentPage=0;
	[self setExpanded:YES];
	[[self view] setFrame:CGRectMake(0.0f, 220.0f, 480.0f, 100.0f)];
	
	NSInteger itemsToLoad = [items count];
	if (itemsToLoad > 4) {
		itemsToLoad = 4;
		canGoForward = YES;
	}
	for (NSInteger i=0; i<itemsToLoad; i++) {
		[self loadItem:i];
	}
	canGoBackward = NO;
}



-(void)viewWillDisappear:(BOOL)animated {
	[[[OperationsManager sharedInstance] queue] cancelAllOperations];
	[[self view] setFrame:CGRectMake(0.0f, 320.0f, 480.0f, 100.0f)];
}


-(IBAction)didClickBack:(id)sender {
	[self setSelectedAction:@"Decorate"];
}


-(IBAction)didClickDecorate:(id)sender {
	[self setSelectedAction:@"Decorate"];
}


-(IBAction)didClickPreviousPage:(id)sender {
	if (canGoBackward) {
		canGoBackward = NO;
		canGoForward = NO;
		currentPage -= 4.0f;
		[scrollView setContentOffset:CGPointMake([scrollView contentOffset].x - (((itemWidth + gutter) * 4)), 0.0f) animated:YES];
	}
}


-(IBAction)didClickNextPage:(id)sender {
	if (canGoForward) {
		canGoBackward = NO;
		canGoForward = NO;
		currentPage += 4.0f;
		[scrollView setContentOffset:CGPointMake([scrollView contentOffset].x + (((itemWidth + gutter) * 4)), 0.0f) animated:YES];
	}
}


-(void)loadItems:(NSString *)theType {
	[self setActiveCategoryKey:theType];
	[self reload:nil];
}


-(IBAction)reload:(id)sender {
	[emptyItemsLabel setHidden:YES];
	[refreshButton setHidden:YES];
	[activityView startAnimating];
	[[OperationsManager sharedInstance] fetchPurchasedItemsForCategory:activeCategoryKey];
}


-(void)didFetchPurchasedItems:(NSMutableArray *)theItems {
	[refreshButton setHidden:YES];
	[activityView stopAnimating];
	[self setItems:theItems];
	
	if ([items count] == 0) {
		[emptyItemsLabel setHidden:NO];
	}
	
	currentPage = 0.0f;
	for (NSInteger i=0; i<[visibleItems count]; i++) {
		[self unloadItem:i];
	}
	
	[self setVisibleItems:[NSMutableArray arrayWithCapacity:[items count]]];
	
	for (NSInteger i=0; i<[items count]; i++) {
		[visibleItems addObject:[NSNull null]];
	}
	
	[scrollView setContentSize:CGSizeMake([items count] * itemWidth + gutter, itemHeight)];
	[scrollView scrollRectToVisible:CGRectMake(0.0f, 0.0f, 10.0f, 10.0f) animated:NO];
	
	
	NSInteger itemsToLoad = [items count];
	if (itemsToLoad > 4) {
		itemsToLoad = 4;
		canGoForward = YES;
	}
	for (NSInteger i=0; i<itemsToLoad; i++) {
		[self loadItem:i];
	}
	
	canGoBackward = NO;
}


-(void)didNotFetchPurchasedItems {
	[refreshButton setHidden:NO];
	[activityView stopAnimating];
}


-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
	[self scrollViewDidEndScrolling];
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
	if (decelerate) {
	} else {
		[self scrollViewDidEndScrolling];
	}
}


-(void)scrollViewDidEndScrolling {
	if (currentPage <= 0.0f) {
		currentPage = 0.0f;
		canGoBackward = NO;
	} else {
		canGoBackward = YES;
	}
	
	if (currentPage > [items count] - 1) {
		currentPage = [items count] - 1;
	} 
	
	CGFloat lastPage = currentPage + 4.0f;
	
	if (lastPage >= [items count]) {
		lastPage = [items count];
		canGoForward = NO;
	} else {
		canGoForward = YES;
	}
	
	for (NSInteger i=0; i<currentPage; i++) {
		[self unloadItem:i];
	}
	for (NSInteger i=currentPage; i<lastPage; i++) {
		[self loadItem:i];
	}
	for (NSInteger i=lastPage; i<[items count]; i++) {
		[self unloadItem:i];
	}
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)sender {
	[self scrollViewDidEndScrolling];
}


-(void)unloadItem:(NSInteger)i {
	if ([visibleItems objectAtIndex:i] == [NSNull null]) {
	} else {
		[[visibleItems objectAtIndex:i] removeFromSuperview];
		[visibleItems replaceObjectAtIndex:i withObject:[NSNull null]];
	}
}


-(void)loadItem:(NSInteger)i {
	if ([visibleItems objectAtIndex:i] == [NSNull null]) {
		Item *item = [items objectAtIndex:i];
		[item setFrame:CGRectMake((i * (itemWidth + gutter)), 5.0f, itemWidth, itemHeight)];
		[[self scrollView] addSubview:item];
		[visibleItems insertObject:item atIndex:i];
		[item startAnimating];
	}
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self setItemToDrop:nil];
	[self setActiveItem:nil];
	id theTouched = [scrollView hitTest:[[touches anyObject] locationInView:scrollView] withEvent:event];
	if (theTouched && [theTouched isKindOfClass:[Item class]]) {
		[self setActiveItem:[theTouched copy]];
		[activeItem setFrame:[theTouched frame]];
		[[self view] addSubview:activeItem];
		[activeItem setCenter:[[touches anyObject] locationInView:[self view]]];
	}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (activeItem) {
		[activeItem setCenter:[[touches anyObject] locationInView:[self view]]];
	}
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (activeItem) {
		if (activeItem.center.y < 0.0f) {
			[activeItem removeFromSuperview];
			[self setItemToDrop:activeItem];
		} else {
			[activeItem removeFromSuperview];
		}
	}
}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


@end