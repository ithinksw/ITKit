//
//  ITAboutBox.m
//  ITKit
//
//  Created by Kent Sutherland on 8/4/05.
//  Copyright 2005 __MyCompanyName__. All rights reserved.
//

#import "ITAboutBox.h"

static ITAboutBox *_sharedController;

@implementation ITAboutBox

+ (ITAboutBox *)sharedController
{
	if (!_sharedController) {
		_sharedController = [[ITAboutBox alloc] init];
	}
	return _sharedController;
}

- (id)init
{
	if ( (self = [super init]) ) {
		[NSBundle loadNibNamed:@"AboutBox" owner:self];
	}
	return self;
}

- (void)setupAboutBox
{
	[_appIcon setImage:[[[NSImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForImageResource:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"]]] autorelease]];
	
	[_appName setStringValue:[[NSBundle mainBundle] localizedStringForKey:@"CFBundleShortVersionString" value:@"" table:@"InfoPlist"]];
	[_companySite setStringValue:@"http://www.ithinksw.com/"];
	
	[_copyright setStringValue:[[NSBundle mainBundle] localizedStringForKey:@"NSHumanReadableCopyright" value:@"" table:@"InfoPlist"]];
}

- (void)showAboutBox
{
	[self setupAboutBox];
	
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
