//
//  ITCategory-NSMenu.m
//  ITKit
//
//  Created by Joseph Spiros on Sat Sep 27 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ITCategory-NSMenu.h"

@interface NSMenu (HACKHACKHACKHACK)
- (id)_menuImpl;
@end

extern void _NSGetMenuItemForCommandKeyEvent (NSMenu *menu, void *chicken, void *taco, void *food); 
extern MenuRef _NSGetCarbonMenu( NSMenu *menu);

@implementation NSMenu (ITCategory)

- (void)indentItem:(NSMenuItem *)item {
    [self indentItem:item toLevel:2];
}

- (void)indentItemAtIndex:(int)index {
    [self indentItemAtIndex:index toLevel:2];
}

- (void)indentItem:(NSMenuItem *)item toLevel:(int)indentLevel {
    [self indentItemAtIndex:[self indexOfItem:item] toLevel:indentLevel];
}

- (void)indentItemAtIndex:(int)index toLevel:(int)indentLevel {
    MenuRef carbonMenu = [self menuRef];
    if (carbonMenu) {
        SetMenuItemIndent(carbonMenu, index + 1, indentLevel);
    }
}

- (MenuRef)menuRef {
    MenuRef carbonMenu;
    int w00t, m00f;
    
    if( [self respondsToSelector:@selector(_menuImpl)] ) {
        [self _menuImpl];
    } else {
        return nil;
    }
    
    _NSGetMenuItemForCommandKeyEvent(self, NULL, &w00t, &m00f); 
    carbonMenu = _NSGetCarbonMenu(self);
    return carbonMenu;
}

@end
