/*
 *	ITKit
 *  ITTabView
 *    NSTabView subclass which includes convenience features
 *
 *  Original Author : Kent Sutherland <kent.sutherland@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Kent Sutherland <kent.sutherland@ithinksw.com>
 *
 *  Copyright (c) 2002 iThink Software.
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
}
@end
