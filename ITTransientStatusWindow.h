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
#import "ITWindowPositioning.h"


#define DEFAULT_EXIT_DELAY  3.0


@class ITTextField;
@class ITGrayRoundedView;
@class ITWindowEffect;


typedef enum {
    ITTransientStatusWindowHiddenState,
    ITTransientStatusWindowAppearingState,
    ITTransientStatusWindowVisibleState,
    ITTransientStatusWindowVanishingState
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

@interface ITTransientStatusWindow : NSWindow <ITWindowPositioning> {

    ITTransientStatusWindowVisibilityState _visibilityState;
    ITTransientStatusWindowExitMode        _exitMode;
    float                                  _exitDelay;
    ITTransientStatusWindowBackgroundType  _backgroundType;
    ITWindowEffect                        *_entryEffect;
    ITWindowEffect                        *_exitEffect;
    ITVerticalWindowPosition               _verticalPosition;
    ITHorizontalWindowPosition             _horizontalPosition;
    float                                  _screenPadding;
    int                                    _screenNumber;

    BOOL _reallyIgnoresEvents;
    
    NSTimer *_delayTimer;

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

- (ITVerticalWindowPosition)verticalPosition;
- (void)setVerticalPosition:(ITVerticalWindowPosition)newPosition;

- (ITHorizontalWindowPosition)horizontalPosition;
- (void)setHorizontalPosition:(ITHorizontalWindowPosition)newPosition;

- (ITWindowEffect *)entryEffect;
- (void)setEntryEffect:(ITWindowEffect *)newEffect;

- (ITWindowEffect *)exitEffect;
- (void)setExitEffect:(ITWindowEffect *)newEffect;


@end
