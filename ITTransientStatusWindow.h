/*
 *	ITKit
 *  ITTransientStatusWindow
 *    NSWindow subclass for quick display of status information.
 *    Similar to volume/brightness/eject bezel key windows.
 *
 *  Original Author : Kent Sutherland <joseph.spiros@ithinksw.com>
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


#define DEFAULT_EXIT_DELAY  3.0
#define DEFAULT_EFFECT_TIME 1.0


@class ITTextField;
@class ITGrayRoundedView;


typedef enum {
    ITTransientStatusWindowHiddenState,
    ITTransientStatusWindowEnteringState,
    ITTransientStatusWindowVisibleState,
    ITTransientStatusWindowExitingState
} ITTransientStatusWindowVisibilityState;

typedef enum {
    ITTransientStatusWindowExitOnOrderOut,
    ITTransientStatusWindowExitAfterDelay,
} ITTransientStatusWindowExitMode;

typedef enum {
    ITTransientStatusWindowNoBackground,
    ITTransientStatusWindowRounded,
    ITTransientStatusWindowSquare,
    ITTransientStatusWindowMetal,
    ITTransientStatusWindowMetalUtility,
    ITTransientStatusWindowAquaUtility
} ITTransientStatusWindowBackgroundType;

typedef enum {
    ITTransientStatusWindowPositionTop,
    ITTransientStatusWindowPositionMiddle,
    ITTransientStatusWindowPositionBottom,
    ITTransientStatusWindowPositionLeft,
    ITTransientStatusWindowPositionCenter,
    ITTransientStatusWindowPositionRight,
    ITTransientStatusWindowOther
} ITTransientStatusWindowPosition;

typedef enum {                                      // Note: Entry effects described here.  Exit does the reverse.
    ITTransientStatusWindowEffectNone,              // No effect, window just appears.
    ITTransientStatusWindowEffectDissolve,          // Fades in.
    ITTransientStatusWindowEffectSlideVertically,   // Slides vertically onto the screen from the nearest edge
    ITTransientStatusWindowEffectSlideHorizontally, // Slides horizontally onto the screen from the nearest edge
    ITTransientStatusWindowEffectPivot              // Rotate into place from perpendicular edge
} ITTransientStatusWindowEffect;


@interface ITTransientStatusWindow : NSWindow {

    ITTransientStatusWindowVisibilityState _visibilityState;
    ITTransientStatusWindowExitMode        _exitMode;
    float                                  _exitDelay;
    ITTransientStatusWindowBackgroundType  _backgroundType;
    ITTransientStatusWindowEffect          _entryEffect;
    ITTransientStatusWindowEffect          _exitEffect;
    float                                  _effectTime;
    double                                 _effectProgress;
    ITTransientStatusWindowPosition        _verticalPosition;
    ITTransientStatusWindowPosition        _horizontalPosition;

    BOOL _reallyIgnoresEvents;
    
    NSTimer *_delayTimer;
    NSTimer *_effectTimer;

//  NSView *_contentSubView;		
}

+ (ITTransientStatusWindow *)sharedWindow;

- (ITTransientStatusWindowVisibilityState)visibilityState;

- (ITTransientStatusWindowExitMode)exitMode;
- (void)setExitMode:(ITTransientStatusWindowExitMode)newMode;

- (float)exitDelay;
- (void)setExitDelay:(float)seconds;

- (ITTransientStatusWindowBackgroundType)backgroundType;
- (void)setBackgroundType:(ITTransientStatusWindowBackgroundType)newType;

- (ITTransientStatusWindowPosition)verticalPosition;
- (void)setVerticalPosition:(ITTransientStatusWindowPosition)newPosition;

- (ITTransientStatusWindowPosition)horizontalPosition;
- (void)setHorizontalPosition:(ITTransientStatusWindowPosition)newPosition;

- (ITTransientStatusWindowEffect)entryEffect;
- (void)setEntryEffect:(ITTransientStatusWindowEffect)newEffect;

- (ITTransientStatusWindowEffect)exitEffect;
- (void)setExitEffect:(ITTransientStatusWindowEffect)newEffect;


@end
