/*
 *	ITKit
 *  ITCategory-NSMenu.h
 *    Category which extends NSMenu
 *
 *  Original Author : Joseph Spiros <joseph.spiros@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2004 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface NSMenu (ITCategory)

- (void)indentItem:(id <NSMenuItem>)item;
- (void)indentItemAtIndex:(int)index;
- (void)indentItem:(id <NSMenuItem>)item toLevel:(int)indentLevel;
- (void)indentItemAtIndex:(int)index toLevel:(int)indentLevel;
- (MenuRef)menuRef;
- (void)removeAllItems;

@end
