#import "ITSplashWindow.h"
#import "ITSplashView.h"

@implementation ITSplashWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(unsigned int)styleMask backing:(NSBackingStoreType)backingType defer:(BOOL)flag
{
	if ( (self = [super initWithContentRect:contentRect styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO]) ) {
		[self setOpaque:NO];
		[self setBackgroundColor:[NSColor clearColor]];
		[self setHasShadow:YES];
	}
	return self;
}

- (BOOL)canBecomeKeyWindow
{
	return YES;
}

- (BOOL)isKeyWindow
{
	return YES;
}

@end
