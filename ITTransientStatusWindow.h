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
#define DEFAULT_EFFECT_TIME 0.75


@class ITTextField;
@class ITGrayRoundedView;
@class ITWindowEffect;


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

@interface ITTransientStatusWindow : NSWindow {

    ITTransientStatusWindowVisibilityState _visibilityState;
    ITTransientStatusWindowExitMode        _exitMode;
    float                                  _exitDelay;
    ITTransientStatusWindowBackgroundType  _backgroundType;
    ITWindowEffect                        *_entryEffect;
    ITWindowEffect                        *_exitEffect;
    float                                  _effectTime;
    double                                 _effectProgress;
    ITTransientStatusWindowPosition        _verticalPosition;
    ITTransientStatusWindowPosition        _horizontalPosition;
    int                                    _screenPadding;

    BOOL _reallyIgnoresEvents;
    
    NSTimer *_delayTimer;
    NSTimer *_effectTimer;

//  NSView *_contentSubView;		
}

+ (id)sharedWindow;

- (id)initWithContentView:(NSView *)contentView
                 exitMode:(ITTransientStatusWindowExitMode)exitMode
           backgroundType:(ITTransientStatusWindowBackgroundType)backgroundType;

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

- (ITWindowEffect *)entryEffect;
- (void)setEntryEffect:(ITWindowEffect *)newEffect;

- (ITWindowEffect *)exitEffect;
- (void)setExitEffect:(ITWindowEffect *)newEffect;


@end
