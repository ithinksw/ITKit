/*
 *	ITKit
 *	ITTSWBackgroundView.h
 *
 *	NSView subclass which draws a translucent background with rounded corners.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

typedef enum _ITTSWBackgroundMode {
    ITTSWBackgroundApple,
    ITTSWBackgroundReadable,
    ITTSWBackgroundColored
} ITTSWBackgroundMode;

@interface ITTSWBackgroundView : NSView {
    NSBezierPath *_path;
    NSColor *_color;
    ITTSWBackgroundMode _mode;
}

- (ITTSWBackgroundMode)backgroundMode;
- (void)setBackgroundMode:(ITTSWBackgroundMode)newMode;

- (NSColor *)backgroundColor;
- (void)setBackgroundColor:(NSColor *)newColor;

@end