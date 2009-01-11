/*
 *	ITKit
 *	ITHotKeyCenter.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@class ITHotKey;

@interface ITHotKeyCenter : NSObject {
	NSMutableDictionary *mHotKeys; //Keys are NSValue of EventHotKeyRef
	BOOL mEventHandlerInstalled;
	BOOL _enabled;
}

+ (id)sharedCenter;

- (BOOL)isEnabled;
- (void)setEnabled:(BOOL)flag;

- (BOOL)registerHotKey:(ITHotKey *)hotKey;
- (void)unregisterHotKey:(ITHotKey *)hotKey;

- (NSArray *)allHotKeys;

- (void)sendEvent:(NSEvent *)event;

@end