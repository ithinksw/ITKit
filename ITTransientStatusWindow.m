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
- (void)startVanishTimer;
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

- (IBAction)appear:(id)sender
{
    if ( _visibilityState == ITTransientStatusWindowHiddenState ) {
         // Window is hidden.  Appear as normal, and start the timer.
        [_entryEffect performAppear];
    } else if ( _visibilityState == ITTransientStatusWindowVisibleState ) {
         // Window is completely visible.  Simply reset the timer.
        [self startVanishTimer];
    } else if ( _visibilityState == ITTransientStatusWindowAppearingState ) {
         // Window is on its way in.  Do nothing.
    } else if ( _visibilityState == ITTransientStatusWindowVanishingState ) {
        // Window is on its way out.  Cancel the vanish.
        [_exitEffect cancelVanish];
    }
}

- (IBAction)vanish:(id)sender
{
    if ( _visibilityState == ITTransientStatusWindowVisibleState ) {
        // Window is totally visible.  Perform exit effect.
        [_exitEffect performVanish];
    } else if ( _visibilityState == ITTransientStatusWindowHiddenState ) {
        // Window is hidden.  Do nothing.
    } else if ( _visibilityState == ITTransientStatusWindowAppearingState ) {
        // Window is on its way in.  Cancel appear.
        [_entryEffect cancelAppear];
    } else if ( _visibilityState == ITTransientStatusWindowVanishingState ) {
        // Window is on its way out.  Do nothing.
    }
}

- (ITWindowVisibilityState)visibilityState
{
    return _visibilityState;
}

- (void)setVisibilityState:(ITWindowVisibilityState)newState
{
    _visibilityState = newState;
    
    if ( _visibilityState == ITTransientStatusWindowVisibleState ) {
        [self startVanishTimer];
    }
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

- (float)effectProgress
{
    return _effectProgress;
}

- (void)setEffectProgress:(float)newProgress
{
    _effectProgress = newProgress;
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

- (void)startVanishTimer
{
    // start timer, if appropriate
    // if timer already exists, restart it.
}

@end
