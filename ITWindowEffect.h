/*
 *	ITKit
 *  ITWindowEffect
 *    Protocal and abstract superclass for performing effects on windows.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


@protocol ITWindowEffect

- (void)performAppear;
- (void)performVanish;

@end


@interface ITWindowEffect : NSObject <ITWindowEffect>
{
    NSWindow *_window;
}

// Designated initializer
- (id)initWithWindow:(NSWindow *)window;

- (NSWindow *)window;

// setWindow: does not retain or release its window.  It simply references it.
- (void)setWindow:(NSWindow *)newWindow;

@end
