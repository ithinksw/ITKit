/*
 *	ITKit
 *	ITTableCornerView.h
 *
 *	NSPopUpButton subclass for use as a cornerView in NSTableView instances.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITTableCornerView : NSPopUpButton {
	NSImage *image;
	NSTableHeaderCell *headerCell;
}

@end