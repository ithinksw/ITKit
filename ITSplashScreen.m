#import "ITSplashScreen.h"
#import "ITSplashWindow.h"
#import "ITSplashView.h"

static ITSplashScreen *_sharedController;

@implementation ITSplashScreen

+ (ITSplashScreen *)sharedController
{
	if (!_sharedController) {
		_sharedController = [[ITSplashScreen alloc] init];
	}
	return _sharedController;
}

- (id)init
{
	if ( (self = [super init]) ) {
		_window = [[ITSplashWindow alloc] initWithContentRect:NSMakeRect(0, 0, 200, 200) styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
		_view = [[ITSplashView alloc] initWithFrame:NSMakeRect(0, 0, 200, 200)];
		[_window setLevel:NSStatusWindowLevel];
		[_window setContentView:[_view autorelease]];
	}
	return self;
}

- (void)dealloc
{
	[_window release];
	[super dealloc];
}

- (double)progressValue
{
	return ([[_view progressIndicator] doubleValue] / 100.0);
}

- (void)setProgressValue:(double)progress
{
	if (progress >= 1.0) {
		[[_view progressIndicator] setIndeterminate:YES];
	} else {
		[[_view progressIndicator] setDoubleValue:(progress * 100.0)];
	}
}

- (NSImage *)image
{
	return [_view image];
}

- (void)setImage:(NSImage *)image
{
	NSRect rect = NSZeroRect, newRect = [_window frame];
	rect.size = [image size];
	newRect.size = rect.size;
	[_window setFrame:newRect display:NO];
	newRect.origin.x = 0;
	newRect.origin.y = 0;
	[_view setFrame:newRect];
	[_view setImage:image];
	[_window center];
}

- (NSString *)string
{
	return [_view string];
}

- (void)setString:(NSString *)string
{
	[_view setString:string];
}

- (void)setSettingsPath:(NSString *)path
{
	[_view loadControlsFromPath:path];
}

- (void)showSplashWindow
{
	//[_window setAlphaValue:0.0];
	[_window makeKeyAndOrderFront:nil];
	//_fadeTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30.0) target:self selector:@selector(showStep:) userInfo:nil repeats:YES];
}

- (void)showStep:(NSTimer *)timer
{
	[_window setAlphaValue:[_window alphaValue] + 0.05];
	if ([_window alphaValue] >= 1.0) {
		[timer invalidate];
		_fadeTimer = nil;
	}
}

- (void)closeSplashWindow
{
	if (_fadeTimer) {
		[_fadeTimer invalidate];
	}
	_fadeTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / 30.0) target:self selector:@selector(closeStep:) userInfo:nil repeats:YES];
}

- (void)closeStep:(NSTimer *)timer
{
	[_window setAlphaValue:[_window alphaValue] - 0.05];
	if ([_window alphaValue] <= 0.0) {
		[timer invalidate];
		_fadeTimer = nil;
		[_window orderOut:nil];
		[_view stopAnimation];
	}
}

@end
