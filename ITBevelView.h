/*
 *	ITKit
 *  ITBevelView
 *    NSView subclass which draws a bevel.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2003 iThink Software.
 *  All Rights Reserved
 *
 */

/*
 *	Draws a bevel of specified thickness, and resizes
 *  its first subview to fill the remaining space.
 */


#import <Cocoa/Cocoa.h>


@interface ITBevelView : NSView {
    int  _bevelDepth;
}

- (int)bevelDepth;
- (void)setBevelDepth:(int)newDepth;


@end
