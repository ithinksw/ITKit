//
//  ITKeyComboPanel.m
//
//  Created by Quentin Carnicelli on Sun Aug 03 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

#import "ITKeyComboPanel.h"

#import "ITHotKey.h"
#import "ITKeyCombo.h"
#import "ITKeyBroadcaster.h"
#import "ITHotKeyCenter.h"

#if __PROTEIN__
#import "NSObjectAdditions.h"
#endif

@implementation ITKeyComboPanel

static id _sharedKeyComboPanel = nil;

+ (id)sharedPanel
{
	if( _sharedKeyComboPanel == nil )
	{
		_sharedKeyComboPanel = [[self alloc] init];
	
		#if __PROTEIN__
			[_sharedKeyComboPanel releaseOnTerminate];
		#endif
	}

	return _sharedKeyComboPanel;
}

- (id)init
{
	return [self initWithWindowNibName: @"ITKeyComboPanel"];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver: self];
	[mKeyName release];

	[super dealloc];
}

- (void)windowDidLoad
{
	[[NSNotificationCenter defaultCenter]
		addObserver: self
		selector: @selector( noteKeyBroadcast: )
		name: ITKeyBroadcasterKeyEvent
		object: mKeyBcaster];
}

- (void)_refreshContents
{
	if( mComboField )
		[mComboField setStringValue: [mKeyCombo description]];

	if( mTitleField )
		[mTitleField setStringValue:mKeyName];
}

- (int)runModal
{
	int resultCode;

	[self window]; //Force us to load

	[self _refreshContents];
	[[self window] center];
	[self showWindow: self];
	resultCode = [[NSApplication sharedApplication] runModalForWindow: [self window]];
	[self close];

	return resultCode;
}

- (void)runModalForHotKey: (ITHotKey*)hotKey
{
	int resultCode;

	[self setKeyBindingName: [hotKey name]];
	[self setKeyCombo: [hotKey keyCombo]];

	resultCode = [self runModal];
	
	if( resultCode == NSOKButton )
	{
		[hotKey setKeyCombo: [self keyCombo]];
		[[ITHotKeyCenter sharedCenter] registerHotKey: hotKey];
	}
}

#pragma mark -

- (void)setKeyCombo: (ITKeyCombo*)combo
{
	[combo retain];
	[mKeyCombo release];
	mKeyCombo = combo;
	[self _refreshContents];
}

- (ITKeyCombo*)keyCombo
{
	return mKeyCombo;
}

- (void)setKeyBindingName: (NSString*)name
{
	[name retain];
	[mKeyName release];
	mKeyName = name;
	[self _refreshContents];
}

- (NSString*)keyBindingName
{
	return mKeyName;
}

#pragma mark -

- (IBAction)ok: (id)sender
{
	[[NSApplication sharedApplication] stopModalWithCode: NSOKButton];
}

- (IBAction)cancel: (id)sender
{
	[[NSApplication sharedApplication] stopModalWithCode: NSCancelButton];
}

- (IBAction)clear: (id)sender
{
	[self setKeyCombo: [ITKeyCombo clearKeyCombo]];
	[[NSApplication sharedApplication] stopModalWithCode: NSOKButton];
}

- (void)noteKeyBroadcast: (NSNotification*)note
{
	ITKeyCombo* keyCombo;
	
	keyCombo = [[note userInfo] objectForKey: @"keyCombo"];

	[self setKeyCombo: keyCombo];
}

@end
