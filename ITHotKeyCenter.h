//
//  ITHotKeyCenter.h
//
//  Created by Quentin Carnicelli on Sat Aug 02 2003.
//  Copyright (c) 2003 iThink Software. All rights reserved.
//

#import <AppKit/AppKit.h>

@class ITHotKey;

@interface ITHotKeyCenter : NSObject
{
	NSMutableDictionary*	mHotKeys; //Keys are NSValue of EventHotKeyRef
	BOOL			mEventHandlerInstalled;
}

+ (id)sharedCenter;

- (BOOL)registerHotKey: (ITHotKey*)hotKey;
- (void)unregisterHotKey: (ITHotKey*)hotKey;

- (NSArray*)allHotKeys;

- (void)sendEvent: (NSEvent*)event;

@end
