/*
 *	ITKit
 *	ITTabView.h
 *
 *	NSTabView subclass which allows dragging (reordering) of tab view items.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITTabView : NSTabView {
	NSTabViewItem *_draggedTab;
	BOOL _allowsDragging;
	unsigned int _requiredModifiers;
}

- (void)setAllowsDragging:(BOOL)flag;
- (BOOL)allowsDragging;

- (void)setRequiredModifiers:(unsigned int)modifiers;
- (unsigned int)requiredModifiers;

- (void)moveTab:(NSTabViewItem *)tab toIndex:(int)index;

@end