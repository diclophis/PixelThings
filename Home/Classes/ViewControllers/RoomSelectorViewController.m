// GPL


#import "Item.h"
#import "ItemSelectorViewController.h"
#import "RoomSelectorViewController.h"
#import "RoomViewController.h"


static NSUInteger kNumberOfPages = 1;


@implementation RoomSelectorViewController


@synthesize scrollView;
@synthesize	viewControllers;
@synthesize editing;
@synthesize activeRoomView;


-(id)init {
	if ((self = [super initWithNibName:@"RoomSelectorViewController" bundle:[NSBundle mainBundle]])) {
	}
	return self;
}


-(void)dealloc {
	[scrollView release];
	[viewControllers release];
	[activeRoomView release];
	[super dealloc];
}


-(void)viewWillDisappear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(-480.0f, 0.0f, 480.0f, 320.0f)];
}


-(void)viewWillAppear:(BOOL)animated {
	[[self view] setFrame:CGRectMake(0.0f, 0.0f, 480.0f, 320.0f)];
}


-(void)viewDidLoad {	
	NSMutableArray *controllers = [[NSMutableArray alloc] init];
	for (unsigned i = 0; i < kNumberOfPages; i++) {
		[controllers addObject:[NSNull null]];
	}
	self.viewControllers = controllers;
	[controllers release];
	
	
	scrollView.contentSize = CGSizeMake(480.0f * kNumberOfPages, 320.0f);
	scrollView.showsHorizontalScrollIndicator = NO;
	scrollView.showsVerticalScrollIndicator = NO;
	scrollView.scrollsToTop = NO;
	scrollView.delegate = self;
	
	[self loadScrollViewWithPage:0];
	[self loadScrollViewWithPage:1];
}	



- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
	
    RoomViewController *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        controller = [[RoomViewController alloc] init];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        [controller release];
    }
		
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = 480.0f * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)sender {
    CGFloat pageWidth = 480.0f;
    currentPage = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;	
    [self loadScrollViewWithPage:currentPage - 1];
    [self loadScrollViewWithPage:currentPage];
    [self loadScrollViewWithPage:currentPage + 1];	
}


-(void)activateCurrentPage {
	[self setEditing:YES];
	[self setActiveRoomView:nil];
	[self setActiveRoomView:[viewControllers objectAtIndex:currentPage]];
	[activeRoomView setEditing:YES];
	[scrollView setScrollEnabled:NO];
}


-(void)cancelEditMode {
	if (editing) {
		[activeRoomView setEditing:NO];
		[scrollView setScrollEnabled:YES];
	}
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	id theItem = [(ItemSelectorViewController *)object itemToDrop];
	if (theItem && [theItem isKindOfClass:[Item class]]) {
		[[self activeRoomView] addItem:theItem];
	}
}


@end
