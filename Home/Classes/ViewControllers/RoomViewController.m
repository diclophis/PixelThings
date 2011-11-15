// GPL


#import "Item.h"
#import "RoomViewController.h"


@implementation RoomViewController


@synthesize editing;
@synthesize removeButton;
@synthesize itemToRemove;
@synthesize items;
@synthesize currentBackground;



-(id)init {
	if ((self = [super initWithNibName:@"RoomViewController" bundle:[NSBundle mainBundle]])) {
		[self setEditing:NO];
		UIButton *theRemovebutton = [[UIButton alloc] initWithFrame:CGRectMake(0,0,30,30)];
		[self setRemoveButton:theRemovebutton];
		[theRemovebutton release];
		[[self view] addSubview:removeButton];
		[removeButton setUserInteractionEnabled:YES];
		[removeButton addTarget:self action:@selector(removeItem:) forControlEvents:UIControlEventTouchUpInside];
		[removeButton setBackgroundImage:[UIImage imageNamed:@"ui_del.png"] forState:UIControlStateNormal];
		[removeButton setBackgroundColor:[UIColor clearColor]];
		[removeButton setHidden:YES];
		[self setItems:[NSMutableArray arrayWithCapacity:0]];
		[items insertObject:[NSNull null] atIndex:0];
	}
	return self;
}


-(void)dealloc {
	[currentBackground release];
	[items release];
	[removeButton release];
	[itemToRemove release];
	[super dealloc];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (editing) {
		id theTouched = [[touches anyObject] view];
		if (theTouched && [theTouched isKindOfClass:[Item class]]) {
			offsetX = [theTouched center].x - [[touches anyObject] locationInView:[self view]].x;
			offsetY = [theTouched center].y - [[touches anyObject] locationInView:[self view]].y;		
		}
	}
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (editing) {
		id theTouched = [[touches anyObject] view];
		if (theTouched && [theTouched isKindOfClass:[Item class]]) {
			CGPoint touchPoint = [[touches anyObject] locationInView:[self view]];
			CGPoint adjustedPoint = CGPointMake(touchPoint.x + offsetX, touchPoint.y + offsetY);
			[theTouched moveTo:adjustedPoint];
		}
	}
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (editing) {
		id theTouched = [[touches anyObject] view];
		if (theTouched && [theTouched isKindOfClass:[Item class]]) {
			if ([[touches anyObject] tapCount] == 1) {
				[theTouched alter];
			} else if ([[touches anyObject] tapCount] == 2) {
				[self setItemToRemove:theTouched];
				[self performSelector:@selector(hideRemoveButton:) withObject:nil afterDelay:3.0f];
				[removeButton setCenter:[theTouched frame].origin];
				[removeButton setHidden:NO];
				[[self view] bringSubviewToFront:removeButton];
			}
		}
	}
}


-(void)removeItem:(id)sender {
	[itemToRemove removeFromSuperview];
	[items removeObject:itemToRemove];
	[self setItemToRemove:nil];
	[removeButton setHidden:YES];
}


-(void)hideRemoveButton:(id)sender {
	[removeButton setHidden:YES];
}


-(void)addItem:(Item *)theItem {
	for (id existingItem in [[self view] subviews]) {
		if ([existingItem isKindOfClass:[Item class]] && [existingItem itemId] == [theItem itemId]) {
			[theItem release];
			return;
		}
	}
	[theItem moveTo:CGPointMake([theItem center].x, [theItem center].y + 200.0f)];
	[[self view] addSubview:theItem];
	CGFloat oldCenterX = [theItem center].x;
	CGFloat oldCenterY = [theItem center].y;
	BOOL recenter = NO;
	if ([theItem constrained]) {
		[theItem setUserInteractionEnabled:NO];
		if ([items objectAtIndex:0] != [NSNull null]) {
			[[items objectAtIndex:0] removeFromSuperview];
		}
		
		[items replaceObjectAtIndex:0 withObject:theItem];
		[theItem setFrame:CGRectMake(0.0f, 0.0f, [theItem image].size.width, [theItem image].size.height)];
		[[self view] sendSubviewToBack:theItem];
	} else {
		recenter = YES;
		[theItem setFrame:CGRectMake(0.0f, 0.0f, [theItem image].size.width, [theItem image].size.height)];
		[items addObject:theItem];
	}
	if (recenter) {
		[theItem moveTo:CGPointMake(oldCenterX, oldCenterY)];
	}
	[theItem drop];
	[theItem release];
}


-(void)reset {
	for (Item *item in items) {
		if ([item isKindOfClass:[Item class]]) {
			[item removeFromSuperview];
		}
	}
	[items removeAllObjects];
	[items insertObject:[NSNull null] atIndex:0];

}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


@end