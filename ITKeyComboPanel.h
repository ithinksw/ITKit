//
//  ITKeyComboPanel.h

//
//  Created by Quentin Carnicelli on Sun Aug 03 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

#import <AppKit/AppKit.h>

@class ITKeyBroadcaster;
@class ITKeyCombo;
@class ITHotKey;

@interface ITKeyComboPanel : NSWindowController
{
	IBOutlet NSTextField*		mTitleField;
	IBOutlet NSTextField*		mComboField;
	IBOutlet ITKeyBroadcaster*	mKeyBcaster;

	NSString*				mTitleFormat;
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
