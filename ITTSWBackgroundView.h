/*
 *	ITKit
 *  ITTSWBackgroundView
 *    NSView subclass which draws a translucent background with rounded corners.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */

#import <Cocoa/Cocoa.h>


typedef enum _ITTSWBackgroundMode {
    ITTSWBackgroundApple,
    ITTSWBackgroundReadable,
    ITTSWBackgroundColored
} ITTSWBackgroundMode;


@interface ITTSWBackgroundView : NSView {
    NSBezierPath        *_path;
    NSColor             *_color;
    ITTSWBackgroundMode  _mode;
}

- (ITTSWBackgroundMode)backgroundMode;
- (void)setBackgroundMode:(ITTSWBackgroundMode)newMode;

- (NSColor *)backgroundColor;
- (void)setBackgroundColor:(NSColor *)newColor;

@end
