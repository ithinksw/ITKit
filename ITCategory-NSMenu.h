/*
 *	ITKit
 *	ITCategory-NSMenu.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface NSMenu (ITKitCategory)

- (void)indentItem:(id <NSMenuItem>)item;
- (void)indentItemAtIndex:(int)index;
- (void)indentItem:(id <NSMenuItem>)item toLevel:(int)indentLevel;
- (void)indentItemAtIndex:(int)index toLevel:(int)indentLevel;
- (MenuRef)menuRef;
- (void)removeAllItems;

@end