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
#import "ITWindowPositioning.h"


#define EFFECT_FPS 30.0
#define DEFAULT_EFFECT_TIME 0.75


@protocol ITWindowEffect

- (void)performAppear;
- (void)performVanish;

@end


@interface ITWindowEffect : NSObject <ITWindowEffect>
{
    NSWindow                   *_window;
    float                       _effectTime;
    double                      _effectProgress;
    ITVerticalWindowPosition    _verticalPosition;
    ITHorizontalWindowPosition  _horizontalPosition;
    NSTimer                    *_effectTimer;
}

// Designated initializer
- (id)initWithWindow:(NSWindow *)window;

- (NSWindow *)window;

// setWindow: does not retain or release its window.  It simply references it.
- (void)setWindow:(NSWindow *)newWindow;

@end
