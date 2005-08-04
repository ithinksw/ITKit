#import "ITURLTextField.h"

@implementation ITURLTextField

- (void)dealloc
{
	[_url release];
	[super dealloc];
}

/*- (void)mouseEntered:(NSEvent *)event
{
	NSLog(@"grr");
	[[NSCursor pointingHandCursor] set];
	[super mouseEntered:event];
}

- (void)mouseExited:(NSEvent *)event
{
	[[NSCursor arrowCursor] set];
	[super mouseExited:event];
}*/

- (void)setURL:(NSURL *)url
{
	[_url release];
	_url = [url retain];
	
	//Make an attributed string for the main stringValue now
//	NSAttributedString *string = [[NSAttributedString alloc] initWithString:[self stringValue] attributes:];
}

@end
