/*
 *	ITKit
 *  ITTabView
 *    NSTabView subclass which includes convenience features
 *
 *  Original Author : Kent Sutherland <kent.sutherland@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Kent Sutherland <kent.sutherland@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */

/*
 *	This subclass enables drag-and-drop for tab view items.
 */


#import <Cocoa/Cocoa.h>


@interface ITTabView : NSTabView
{
    NSTabViewItem *_draggedTab;
    bool _allowsDragging;
}

- (void)setAllowsDragging:(bool)flag;
- (bool)allowsDragging;

- (void)moveTab:(NSTabViewItem *)tab toIndex:(int)index;


@end
