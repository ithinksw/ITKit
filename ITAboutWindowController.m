#import "ITAboutWindowController.h"

static ITAboutWindowController *_sharedController;

@implementation ITAboutWindowController

+ (ITAboutWindowController *)sharedController
{
	if (!_sharedController) {
		_sharedController = [[ITAboutWindowController alloc] init];
	}
	return _sharedController;
}

- (id)init
{
	if ( (self = [super init]) ) {
		[NSBundle loadNibNamed:@"ITAboutWindow" owner:self];
	}
	return self;
}

- (void)setupAboutWindow
{
	[_appIcon setImage:[[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"]]] autorelease]];
	
	[_appName setStringValue:[[NSBundle mainBundle] localizedStringForKey:@"CFBundleShortVersionString" value:@"" table:@"InfoPlist"]];
	[_companySite setStringValue:@"http://www.ithinksw.com/"];
	
	[_copyright setStringValue:[[NSBundle mainBundle] localizedStringForKey:@"NSHumanReadableCopyright" value:@"" table:@"InfoPlist"]];
}

- (void)showAboutWindow
{
	[self setupAboutWindow];
	
	[_window center];
	[NSApp activateIgnoringOtherApps:YES];
    [_window orderFrontRegardless];
    [_window makeKeyWindow];
}

- (BOOL)isVisible
{
	return [_window isVisible];
}

@end