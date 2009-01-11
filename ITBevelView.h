/*
 *	ITKit
 *	ITBevelView.h
 *
 *	NSView subclass which draws a bevel of specified thickness, and resizes its
 *		first subview to fill the remaining space.
 *
 *	Copyright (c) 2005 iThink Software.
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITBevelView : NSView {
	int _bevelDepth;
}

- (int)bevelDepth;
- (void)setBevelDepth:(int)newDepth;

@end