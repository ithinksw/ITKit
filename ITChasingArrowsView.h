/*
 *	ITKit
 *  ITStatusItem
 *    NSStatusItem subclass which reduces suckage
 *
 *  Original Author : Doug Brown
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 iThink Software.
 *  All Rights Reserved
 *
 */

#import <AppKit/AppKit.h>


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
