// GPL

#import "ChatViewController.h"


#define BUMP 160.0f


@implementation ChatViewController


@synthesize myWebView;
@synthesize myMessageField;
@synthesize bumped;


-(void)dealloc {
	[myWebView stopLoading];
	[myWebView removeFromSuperview];
	[myWebView release];
	[myMessageField removeFromSuperview];
	[myMessageField release];
	[super dealloc];
}


-(id)init {
	if ((self = [super initWithNibName:@"ChatViewController" bundle:[NSBundle mainBundle]])) {
		[self setBumped:NO];
	}
	return self;
}


-(void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[myWebView loadData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"chat" ofType:@"html"]] MIMEType:@"text/html" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@"http://google.com/"]];
}


-(void)webViewDidFinishLoad:(UIWebView *)webView {
	[myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"connect_with_username_and_password('%@', '%@');", [[NSUserDefaults standardUserDefaults] objectForKey:@"Account.JID"], [[NSUserDefaults standardUserDefaults] objectForKey:@"Account.Password"]]];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	NSString *message = [[[textField text] stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""] stringByReplacingOccurrencesOfString:@"\'" withString:@"\\'"];
	[myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"send_message('%@');", message]];
	[textField setText:@""];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField {
	[self bumpUp];
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
	[self bumpDown];
}


-(void)bumpUp {
	if (!bumped) {
		[self setBumped:YES];
		[UIView beginAnimations:@"bumpUp" context:nil];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(bumpingStopped:finished:context:)];
		[myMessageField setFrame:CGRectOffset([myMessageField frame], 0.0f, -BUMP)];
		[myWebView setFrame:CGRectMake([myWebView frame].origin.x, [myWebView frame].origin.y, [myWebView frame].size.width, [myWebView frame].size.height - BUMP)];
		[UIView commitAnimations];
	}
}


-(void)bumpDown {
	if (bumped) {
		[self setBumped:NO];
		[UIView beginAnimations:@"bumpUp" context:nil];
		[UIView setAnimationDuration:ANIMATION_DURATION];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(bumpingStopped:finished:context:)];
		[myMessageField setFrame:CGRectOffset([myMessageField frame], 0.0f, BUMP)];
		[myWebView setFrame:CGRectMake([myWebView frame].origin.x, [myWebView frame].origin.y, [myWebView frame].size.width, [myWebView frame].size.height + BUMP)];
		[UIView commitAnimations];
	}
}


-(void)bumpingStopped:(NSString *)animationID finished:(BOOL)finished context:(void *)context {
	[myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"scroll_to_bottom();"]];
}


-(IBAction)didClickBack:(id)sender {
	[myWebView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"disconnect();"]];
	[self setSelectedAction:@"Community"];
}
	 

@end