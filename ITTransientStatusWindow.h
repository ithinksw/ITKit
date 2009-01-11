/*
 *	ITKit
 *	ITTransientStatusWindow.h
 *
 *	NSWindow subclass for quick display of status information, similar to
 *		volume/brightness/eject bezel key windows.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITKit/ITWindowPositioning.h>
#import <ITKit/ITWindowEffect.h>

#define DEFAULT_EXIT_DELAY 3.0

@class ITTextField;
@class ITGrayRoundedView;

typedef enum {
	ITTransientStatusWindowExitOnCommand,
	ITTransientStatusWindowExitAfterDelay
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
	ITTransientStatusWindowRegular,
	ITTransientStatusWindowSmall,
	ITTransientStatusWindowMini
} ITTransientStatusWindowSizing;

@interface ITTransientStatusWindow : NSWindow <ITWindowPositioning, ITWindowMotility> {
	ITWindowVisibilityState _visibilityState;
	ITTransientStatusWindowExitMode _exitMode;
	float _exitDelay;
	ITTransientStatusWindowBackgroundType _backgroundType;
	ITWindowEffect *_entryEffect;
	ITWindowEffect *_exitEffect;
	double _effectProgress;
	ITVerticalWindowPosition _verticalPosition;
	ITHorizontalWindowPosition _horizontalPosition;
	ITTransientStatusWindowSizing _sizing;
	float _screenPadding;
	NSScreen *_screen;
	BOOL _reallyIgnoresEvents;
	NSTimer *_exitTimer;
	NSView *_contentSubView;		
}

+ (ITTransientStatusWindow *)sharedWindow;

- (id)initWithContentView:(NSView *)contentView exitMode:(ITTransientStatusWindowExitMode)exitMode backgroundType:(ITTransientStatusWindowBackgroundType)backgroundType;

- (void)appear:(id)sender;
- (void)vanish:(id)sender;

- (void)setSizing:(ITTransientStatusWindowSizing)newSizing;
- (ITTransientStatusWindowSizing)sizing;

- (ITWindowVisibilityState)visibilityState;
- (void)setVisibilityState:(ITWindowVisibilityState)newState;

- (ITTransientStatusWindowExitMode)exitMode;
- (void)setExitMode:(ITTransientStatusWindowExitMode)newMode;

- (float)exitDelay;
- (void)setExitDelay:(float)seconds;

- (ITTransientStatusWindowBackgroundType)backgroundType;
- (void)setBackgroundType:(ITTransientStatusWindowBackgroundType)newType;

- (float)effectProgress;
- (void)setEffectProgress:(float)newProgress;

- (ITWindowEffect *)entryEffect;
- (void)setEntryEffect:(ITWindowEffect *)newEffect;

- (ITWindowEffect *)exitEffect;
- (void)setExitEffect:(ITWindowEffect *)newEffect;

@end