#import "ITCategory-NSMenu.h"

extern void _NSGetMenuItemForCommandKeyEvent(NSMenu *menu, void *chicken, void *taco, void *food); 
extern MenuRef _NSGetCarbonMenu(NSMenu *menu);

@interface NSMenu (ITKitCategoryHacks)
- (id)_menuImpl;
@end

@protocol _ITKitCategoryNSMenuItemPantherCompatability <NSMenuItem>
- (int)indentationLevel;
- (void)setIndentationLevel:(int)indentationLevel;
@end

@implementation NSMenu (ITKitCategory)

- (void)indentItem:(id <NSMenuItem>)item {
	[self indentItem:item toLevel:1];
}

- (void)indentItemAtIndex:(int)index {
	[self indentItemAtIndex:index toLevel:1];
}

- (void)indentItem:(id <NSMenuItem>)item toLevel:(int)indentLevel {
	[self indentItemAtIndex:[self indexOfItem:item] toLevel:indentLevel];
}

- (void)indentItemAtIndex:(int)index toLevel:(int)indentLevel {
	id <NSMenuItem> theItem = [self itemAtIndex:index];
	if ([theItem respondsToSelector:@selector(setIndentationLevel:)]) {
	    [(id <_ITKitCategoryNSMenuItemPantherCompatability>)theItem setIndentationLevel:indentLevel];
	} else {
	    MenuRef carbonMenu = [self menuRef];
	    if (carbonMenu) {
	        SetMenuItemIndent(carbonMenu, index + 1, indentLevel);
	    }
	}
}

- (MenuRef)menuRef {
	MenuRef carbonMenu;
	int w00t, m00f;
	
	if ([self respondsToSelector:@selector(_menuImpl)]) {
	    (void)[self _menuImpl];
	} else {
	    return nil;
	}
	
	_NSGetMenuItemForCommandKeyEvent(self, NULL, &w00t, &m00f); 
	carbonMenu = _NSGetCarbonMenu(self);
	return carbonMenu;
}

- (void)removeAllItems {
	int numOfItems = [self numberOfItems];
	int i = numOfItems;
	
	while (i != 0) {
		[self removeItemAtIndex:(i-1)];
		i--;
	}
}

@end