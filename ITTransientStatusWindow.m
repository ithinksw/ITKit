#import "ITTransientStatusWindow.h"
#import "ITWindowEffect.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ITCoreGraphicsHacks.h"
#import "ITTextField.h"
#import "ITGrayRoundedView.h"

#define EFFECT_FPS 30.0


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHOD DECLARATIONS
/*************************************************************************/

@interface ITTransientStatusWindow (Private)
- (id)initWithContentView:(NSView *)contentView
                 exitMode:(ITTransientStatusWindowExitMode)exitMode
           backgroundType:(ITTransientStatusWindowBackgroundType)backgroundType;
- (void)rebuildWindow;
// - (void)performEffect;
@end


/*************************************************************************/
#pragma mark -
#pragma mark IMPLEMENTATION
/*************************************************************************/

@implementation ITTransientStatusWindow


/*************************************************************************/
#pragma mark -
#pragma mark SHARED STATIC OBJECTS
/*************************************************************************/

static ITTransientStatusWindow *staticWindow = nil;


/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

+ (ITTransientStatusWindow *)sharedWindow
{
    if ( ! (staticWindow) ) {
        staticWindow = [[self alloc] initWithContentView:nil
                                                exitMode:ITTransientStatusWindowExitAfterDelay
                                          backgroundType:ITTransientStatusWindowRounded];
    }
    return staticWindow;
}

- (id)initWithContentView:(NSView *)contentView
                 exitMode:(ITTransientStatusWindowExitMode)exitMode
           backgroundType:(ITTransientStatusWindowBackgroundType)backgroundType
{
    NSRect contentRect;
    
    // If no Content View was provided, use a generic view.
    if ( ! (contentView) ) {
        contentView = [[[NSView alloc] initWithFrame:
            NSMakeRect(100.0, 100.0, 200.0, 200.0)] autorelease];
    }
    
    // Set the content rect to the frame of the content view, now guaranteed to exist.
    contentRect = [contentView frame];
    
    if ( ( self = [super initWithContentRect:contentRect
                                   styleMask:NSBorderlessWindowMask
                                     backing:NSBackingStoreBuffered
                                       defer:NO] ) ) {
                                    
        _visibilityState     = ITTransientStatusWindowHiddenState;
        _exitMode            = exitMode;
        _exitDelay           = DEFAULT_EXIT_DELAY;
        _backgroundType      = backgroundType;
        _verticalPosition    = ITWindowPositionBottom;
        _horizontalPosition  = ITWindowPositionLeft;
        _screenPadding       = 32.0;
        _screenNumber        = 0;
        _entryEffect         = nil;
        _exitEffect          = nil;
        _reallyIgnoresEvents = YES;
        _delayTimer          = nil;

//      if ( _backgroundType == ITTransientStatusWindowRounded ) {
//          _contentSubView = contentView;
//      } else {
//          [self setContentView:contentView];
//      }

        [self setIgnoresMouseEvents:YES];
        [self setLevel:NSScreenSaverWindowLevel];
        [self setContentView:contentView];
        [self rebuildWindow];
    }
    return self;
}


/*************************************************************************/
#pragma mark -
#pragma mark INSTANCE METHODS
/*************************************************************************/

- (BOOL)ignoresMouseEvents
{
    return _reallyIgnoresEvents;
}

- (void)setIgnoresMouseEvents:(BOOL)flag
{
    CGSValueObj   	 key;
    CGSValueObj   	 ignore;

    key = CGSCreateCString("IgnoreForEvents");
    ignore = CGSCreateBoolean( (flag ? kCGSTrue : kCGSFalse) );
    CGSSetWindowProperty([NSApp contextID], (CGSWindowID)[self windowNumber], key, ignore);
    CGSReleaseObj(key);
    CGSReleaseObj(ignore);

    _reallyIgnoresEvents = flag;
}

/*

- (void)orderFront:(id)sender
{
    if ( _entryEffect == nil ) {
        [super orderFront:sender];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [self performEffect];
    }
    if ( _exitMode == ITTransientStatusWindowExitAfterDelay ) {
        // set the timer, and orderOut: when it lapses.
    }
}

- (void)makeKeyAndOrderFront:(id)sender
{
    if ( _exitMode == ITTransientStatusWindowExitAfterDelay ) {
        // set the timer, and orderOut: when it lapses.
    }

    if ( _entryEffect == nil ) {
        [super makeKeyAndOrderFront:sender];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [self performEffect];
        [self makeKeyWindow];
    }
}

- (void)orderOut:(id)sender
{
    if ( _entryEffect == nil ) {
        [super orderOut:sender];
        _visibilityState = ITTransientStatusWindowHiddenState;
    } else {
        [self performEffect];
    }
}

- (NSTimeInterval)animationResizeTime:(NSRect)newFrame
{
    return _resizeTime;
}

- (id)contentView
{
    if ( _backgroundType == ITTransientStatusWindowRounded ) {
        return _contentSubView;
    } else {
        return [super contentView];
    }
}

- (void)setContentView:(NSView *)aView
{
    if ( _backgroundType == ITTransientStatusWindowRounded ) {
       [_contentSubView removeFromSuperview];
        _contentSubView = aView;
        [_contentSubView setFrame:[[super contentView] frame]];
        [[super contentView] addSubview:_contentSubView];
        [_contentSubView setNextResponder:self];
    } else {
        [super setContentView:aView];
    }
}

*/

- (void)appear
{
    if ( _entryEffect == nil ) {
        [self orderFront:self];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        _visibilityState = ITTransientStatusWindowAppearingState;
        [_entryEffect performAppear];
        _visibilityState = ITTransientStatusWindowVisibleState;
    }
    if ( _exitMode == ITTransientStatusWindowExitAfterDelay ) {
        // set the timer, and vanish when it lapses.
    }
}

- (void)vanish
{
    if ( _entryEffect == nil ) {
        [self orderOut:self];
        _visibilityState = ITTransientStatusWindowHiddenState;
    } else {
        [_exitEffect performVanish];
        _visibilityState = ITTransientStatusWindowHiddenState;
    }
}

- (ITTransientStatusWindowVisibilityState)visibilityState
{
    return _visibilityState;
}

- (ITTransientStatusWindowExitMode)exitMode
{
    return _exitMode;
}

- (void)setExitMode:(ITTransientStatusWindowExitMode)newMode
{
    _exitMode = newMode;
}

- (float)exitDelay
{
    return _exitDelay;
}

- (void)setExitDelay:(float)seconds
{
    _exitDelay = seconds;
}

- (ITTransientStatusWindowBackgroundType)backgroundType
{
//  return _backgroundType;
    return ITTransientStatusWindowRounded;
}

- (void)setBackgroundType:(ITTransientStatusWindowBackgroundType)newType
{
//  setBackgroundType: is currently ignored.  Defaults to ITTransientStatusWindowRounded.
//  _backgroundType = newType;
    _backgroundType = ITTransientStatusWindowRounded;
}

- (ITVerticalWindowPosition)verticalPosition;
{
    return _verticalPosition;
}

- (void)setVerticalPosition:(ITVerticalWindowPosition)newPosition;
{
    _verticalPosition = newPosition;
}

- (ITHorizontalWindowPosition)horizontalPosition;
{
    return _horizontalPosition;
}

- (void)setHorizontalPosition:(ITHorizontalWindowPosition)newPosition;
{
    _horizontalPosition = newPosition;
}

- (float)screenPadding
{
    return _screenPadding;
}

- (void)setScreenPadding:(float)newPadding
{
    _screenPadding = newPadding;
}

- (int)screenNumber
{
    return _screenNumber;
}

- (void)setScreenNumber:(int)newNumber
{
    _screenNumber = newNumber;
}

- (ITWindowEffect *)entryEffect
{
    return _entryEffect;
}

- (void)setEntryEffect:(ITWindowEffect *)newEffect
{
    [_entryEffect autorelease];
    _entryEffect = [newEffect retain];
}

- (ITWindowEffect *)exitEffect
{
    return _exitEffect;
}

- (void)setExitEffect:(ITWindowEffect *)newEffect
{
    [_exitEffect autorelease];
    _exitEffect = [newEffect retain];
}


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHODS
/*************************************************************************/

- (void)rebuildWindow;
{
    if ( _backgroundType == ITTransientStatusWindowRounded ) {
        ITGrayRoundedView *roundedView = [[[ITGrayRoundedView alloc] initWithFrame:[self frame]] autorelease];

        [self setBackgroundColor:[NSColor clearColor]];
        [self setHasShadow:NO];
        [self setOpaque:NO];
        
        [self setContentView:roundedView];
//      [super setContentView:roundedView];
//      [_contentSubView setAutoresizingMask:(NSViewWidthSizable | NSViewHeightSizable)];
//      [self setContentView:_contentSubView];
    } else {
        // YUO == CLWONBAOT
    }
}

/*

- (void)performEffect
{
    if ( _visibilityState == ITTransientStatusWindowHiddenState ) {
        _visibilityState = ITTransientStatusWindowEnteringState;
    } else if ( _visibilityState == ITTransientStatusWindowVisibleState ) {
        _visibilityState = ITTransientStatusWindowExitingState;
    } else {
        return;
    }
        
    if ( _entryEffect == ITTransientStatusWindowEffectDissolve ) {
        [self dissolveEffect];
    } else if ( _entryEffect == ITTransientStatusWindowEffectSlideVertically ) {
        [self slideVerticalEffect];
    } else if ( _entryEffect == ITTransientStatusWindowEffectSlideHorizontally ) {
        [self slideHorizontalEffect];
    } else if ( _entryEffect == ITTransientStatusWindowEffectPivot ) {
        [self pivotEffect];
    }
}

*/


@end
