/*
 *	ITKit
 *  ITGrayRoundedView
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


@interface ITGrayRoundedView : NSView {
    NSBezierPath *_path;
}

@end
