/*
 *	ITKit
 *  ITHotKeyCenter
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
