/*
 *	ITKit
 *	ITTableView
 *
 *	An NSTableView subclass with easy to use accessors for adding a menu (with optional image)
 *	to the corner view of the TableView.
 *
 *	Original Author	: Joseph Spiros <joseph.spiros@ithinksw.com>
 *	Responsibility	: Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *	Copyright (c) 2002 iThink Software.
 *	All Rights Reserved
 *
 */

#import <AppKit/AppKit.h>
#import "ITTableCornerView.h"

@interface ITTableView : NSTableView {
    ITTableCornerView *corner;
}

- (void)setCornerImage:(NSImage*)image;
- (NSImage*)cornerImage;
- (void)setCornerMenu:(NSMenu*)menu;
- (NSMenu*)cornerMenu;

@end
