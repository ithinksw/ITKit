/*
 *	ITKit
 *  ITChasingArrowsView
 *    Animating Asynchronous Arrows Widget
 *    *** DEPRECATED: NSProgressIndicator now offers an async mode.  MLJ - 01/14/2003
 *
 *  Original Author : Doug Brown <...>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


@interface ITChasingArrowsView : NSView
{
    BOOL running, inForeground;
    int curIndex;
    NSTimer *timer;
    NSArray *images;
}

- (IBAction)stop:(id)sender;
- (IBAction)start:(id)sender;


@end
