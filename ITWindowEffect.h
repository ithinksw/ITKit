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

@class ITTransientStatusWindow;

#define EFFECT_FPS 30.0
#define DEFAULT_EFFECT_TIME 0.75


typedef enum {
    ITTransientStatusWindowHiddenState,
    ITTransientStatusWindowAppearingState,
    ITTransientStatusWindowVisibleState,
    ITTransientStatusWindowVanishingState
} ITWindowVisibilityState;


@protocol ITWindowEffect
- (void)performAppear;
- (void)performVanish;
- (void)cancelAppear;
- (void)cancelVanish;
@end


@protocol ITWindowMotility
- (ITWindowVisibilityState)visibilityState;
- (void)setVisibilityState:(ITWindowVisibilityState)newState;
- (float)effectProgress;
- (void)setEffectProgress:(float)newProgress;
@end


@interface ITWindowEffect : NSObject <ITWindowEffect>
{
    ITTransientStatusWindow    *_window;
    float                       _effectTime;
    float                       _effectSpeed;
    ITVerticalWindowPosition    _verticalPosition;
    ITHorizontalWindowPosition  _horizontalPosition;
    NSTimer                    *_effectTimer;
}

// Designated initializer
- (id)initWithWindow:(NSWindow *)window;

- (NSWindow *)window;

- (void)setWindow:(NSWindow *)newWindow;

- (void)setWindowVisibility:(ITWindowVisibilityState)visibilityState;

- (float)effectTime;
- (void)setEffectTime:(float)newTime;

@end
