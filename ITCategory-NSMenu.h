//
//  ITCategory-NSMenu.h
//  ITKit
//
//  Created by Joseph Spiros on Sat Sep 27 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Carbon/Carbon.h>

@interface NSMenu (ITCategory)

- (void)indentItem:(NSMenuItem *)item;
- (void)indentItemAtIndex:(int)index;
- (void)indentItem:(NSMenuItem *)item toLevel:(int)indentLevel;
- (void)indentItemAtIndex:(int)index toLevel:(int)indentLevel;
- (MenuRef)menuRef;

@end
