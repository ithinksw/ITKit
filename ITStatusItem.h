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

@interface ITStatusItem : NSStatusItem {

}

- (id)initWithStatusBar:(NSStatusBar *)statusBar withLength:(float)length;

- (NSImage *)alternateImage;
- (void)setAlternateImage:(NSImage *)image;

@end