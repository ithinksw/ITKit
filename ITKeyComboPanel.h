/*
 *	ITKit
 *  ITKeyComboPanel
 *
 *  Original Author : Quentin Carnicelli <...>
 *   Responsibility : Kent Sutherland <kent.sutherland@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <AppKit/AppKit.h>


@class ITKeyBroadcaster;
@class ITKeyCombo;
@class ITHotKey;


@interface ITKeyComboPanel : NSWindowController
{
	IBOutlet NSTextField*		mTitleField;
	IBOutlet NSTextField*		mComboField;
	IBOutlet ITKeyBroadcaster*	mKeyBcaster;

	NSString*				mKeyName;
	ITKeyCombo*				mKeyCombo;
}

+ (id)sharedPanel;

- (int)runModal;
- (void)runModalForHotKey: (ITHotKey*)hotKey;

- (void)setKeyCombo: (ITKeyCombo*)combo;
- (ITKeyCombo*)keyCombo;

- (void)setKeyBindingName: (NSString*)name;
- (NSString*)keyBindingName;

- (IBAction)ok: (id)sender;
- (IBAction)cancel: (id)sender;
- (IBAction)clear: (id)sender;


@end
