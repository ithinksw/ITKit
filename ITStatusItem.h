/*
 *	ITKit
 *	ITStatusItem.h
 *
 *	NSStatusItem subclass which attempts to approximate NSMenuExtra's
 *		appearance and functionality.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

@class ITStatusItem;

@protocol ITStatusItemMenuProvider
- (NSMenu *)menuForStatusItem:(ITStatusItem *)statusItem;
@end

@interface ITStatusItem : NSStatusItem {
	id <ITStatusItemMenuProvider> _menuProvider;
	NSMenu *_menuProxy;
}

- (id)initWithStatusBar:(NSStatusBar *)statusBar withLength:(float)length;

- (NSImage *)alternateImage;
- (void)setAlternateImage:(NSImage *)image;

- (id <ITStatusItemMenuProvider>)menuProvider;
- (void)setMenuProvider:(id <ITStatusItemMenuProvider>)provider;

@end