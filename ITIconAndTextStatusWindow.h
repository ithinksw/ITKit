/*
 *	ITKit
 *  ITIconAndTextStatusWindow
 *    ITTransientStatusWindow subclass to show an icon and text.
 *
 *  Original Author : Kent Sutherland <ksutherland@ithinksw.com>
 *   Responsibility : Kent Sutherland <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2004 iThink Software.
 *  All Rights Reserved
 *
 */

#import <Cocoa/Cocoa.h>
#import "ITTransientStatusWindow.h"

@interface ITIconAndTextStatusWindow : ITTransientStatusWindow {
        NSImage            *_image;
}

- (void)setImage:(NSImage *)newImage;
- (void)buildTextWindowWithString:(NSString *)text;

@end
