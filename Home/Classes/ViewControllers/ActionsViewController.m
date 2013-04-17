// GPL

#import "ActionsViewController.h"
#import "AnimationSystem.h"
#import "AnimatedPerson.h"

@implementation ActionsViewController

@synthesize animatedPerson;

-(ActionsViewController *)initWithAnimatedPerson:(AnimatedPerson *)thePerson
{
	[self setAnimatedPerson:thePerson];
	if ((self = [super initWithNibName:@"ActionsViewController" bundle:[NSBundle mainBundle]])) {
		changeMeSection = -1;
		actionsSection = -1;
	}
	return self;
}

-(IBAction)didClickClose:(id)sender
{
	[animatedPerson hideActionsMenu];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	int sections = 0;
	if ([animatedPerson enableChangeMe])
	{
		changeMeSection = sections;
		sections++;
	}
	if ([animatedPerson enableAnimations])
	{
		actionsSection = sections;
		sections++;
	}
	return sections;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	int rows = 0;
	if (section == changeMeSection)
	{
		rows = 1;
	}
	else if (section == actionsSection)
	{
		rows = [[animatedPerson animations] count];
	}
	return rows;
}

- (UITableViewCell *)tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [theTableView dequeueReusableCellWithIdentifier:@"actionsMenuCell"];
	UILabel *title;
	if (cell == nil) {
		CGRect frame = CGRectMake(0, 0, 100, 30);
		cell = [[[UITableViewCell alloc] initWithFrame:frame reuseIdentifier:@"actionsMenuCell"] autorelease];
		[cell.contentView setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f]];
		title = [[[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30.0)] autorelease];
		[title setBackgroundColor:[UIColor clearColor]];
		title.tag = 1;
		title.font = [UIFont boldSystemFontOfSize:14.0];
		//title.textAlignment = UITextAlignmentLeft;
		title.textColor = [UIColor whiteColor];
		[cell.contentView addSubview:title];
	} else {
		title = (UILabel *)[cell.contentView viewWithTag:1];
	}
	if ([indexPath section] == changeMeSection)
	{
		[title setText:@"Change Me"];
	}
	else if ([indexPath section] == actionsSection)
	{
		[title setText:[[animatedPerson animations] objectAtIndex:[indexPath row]]];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([indexPath section] == changeMeSection)
	{
		[animatedPerson doChangeMe];
	}
	else if ([indexPath section] == actionsSection)
	{
		NSString *selectedAnimation = [[animatedPerson animations] objectAtIndex:[indexPath row]];
		if ([selectedAnimation isEqualToString:@"debug"])
		{
		}
		else {
			[animatedPerson playAnimation:selectedAnimation];			
			[[NSNotificationCenter defaultCenter] postNotificationName:@"interactWithFriend" object:self userInfo:[NSDictionary dictionaryWithObject:selectedAnimation forKey:@"interaction"]];
			[animatedPerson hideActionsMenu];
		}
	}
}

-(void)dealloc {
	[self setAnimatedPerson:nil];
	[super dealloc];
}

-(void)didGetStoreItems:(NSArray *)theItems
{
}

-(void)didNotGetStoreItems
{
}

@end
