#import "ITTransientStatusWindow.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ITCoreGraphicsHacks.h"
#import "ITTextField.h"
#import "ITGrayRoundedView.h"

@class ITTextField;
@class ITGrayRoundedView;

/*************************************************************************/
#pragma mark -
#pragma mark EVIL HACKERY
/*************************************************************************/

@interface NSApplication (HACKHACKHACKHACK)
- (CGSConnectionID)contextID;
@end


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHOD DECLARATIONS
/*************************************************************************/

@interface ITTransientStatusWindow (Private)
- (id)initWithContentView:(NSView *)contentView
                 exitMode:(ITTransientStatusWindowExitMode)exitMode
           backgroundType:(ITTransientStatusWindowBackgroundType)backgroundType;
- (void)rebuildWindow;
- (void)performEffect;
- (void)dissolveEffect:(BOOL)entering;
- (void)slideVerticalEffect:(BOOL)entering;
- (void)slideHorizontalEffect:(BOOL)entering;
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
    
    CGSValueObj   	 key;
    CGSValueObj   	 ignore;

    // If no Content View was provided, use a generic NSImageView with the app icon.
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
                                    
        _visibilityState    = ITTransientStatusWindowHiddenState;
        _exitMode           = exitMode;
        _exitDelay          = DEFAULT_EXIT_DELAY;
        _backgroundType     = backgroundType;
        _verticalPosition   = ITTransientStatusWindowPositionBottom;
        _horizontalPosition = ITTransientStatusWindowPositionLeft;
        _entryEffect        = ITTransientStatusWindowEffectNone;
        _exitEffect         = ITTransientStatusWindowEffectDissolve;
        
        _delayTimer = nil;
        _fadeTimer  = nil;

//        if ( _backgroundType == ITTransientStatusWindowRounded ) {
//            _contentSubView = contentView;
//        } else {
//            [self setContentView:contentView];
//        }

//      [self setIgnoresMouseEvents:YES];

        key = CGSCreateCString("IgnoreForEvents");
        ignore = CGSCreateBoolean(kCGSTrue);
        
        CGSSetWindowProperty([NSApp contextID], (CGSWindowID)[self windowNumber], key, ignore);

        CGSReleaseObj(key);
        CGSReleaseObj(ignore);
        
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

- (void)orderFront:(id)sender
{
    if ( _exitMode == ITTransientStatusWindowExitAfterDelay ) {
        // set the timer, and orderOut: when it lapses.
    }

    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
        [super orderFront:sender];
    } else {
        [self performEffect];
    }
}

- (void)makeKeyAndOrderFront:(id)sender
{
    if ( _exitMode == ITTransientStatusWindowExitAfterDelay ) {
        // set the timer, and orderOut: when it lapses.
    }

    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
        [super makeKeyAndOrderFront:sender];
    } else {
        [self performEffect];
        [self makeKeyWindow];
    }
}

- (void)orderOut:(id)sender
{
    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
        [super orderOut:sender];
    } else {
        [self performEffect];
    }
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

- (ITTransientStatusWindowPosition)verticalPosition;
{
    return _verticalPosition;
}

- (void)setVerticalPosition:(ITTransientStatusWindowPosition)newPosition;
{
    _verticalPosition = newPosition;
}

- (ITTransientStatusWindowPosition)horizontalPosition;
{
    return _horizontalPosition;
}

- (void)setHorizontalPosition:(ITTransientStatusWindowPosition)newPosition;
{
    _horizontalPosition = newPosition;
}

- (ITTransientStatusWindowEffect)entryEffect
{
    return _entryEffect;
}

- (void)setEntryEffect:(ITTransientStatusWindowEffect)newEffect;
{
    _entryEffect = newEffect;
}

- (ITTransientStatusWindowEffect)exitEffect;
{
    return _exitEffect;
}

- (void)setExitEffect:(ITTransientStatusWindowEffect)newEffect;
{
    _exitEffect = newEffect;
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

- (void)performEffect
{
    if ( _visibilityState == ITTransientStatusWindowHiddenState ) {
        if ( _entryEffect == ITTransientStatusWindowEffectDissolve ) {
            [self dissolveEffect:YES];
        } else if ( _entryEffect == ITTransientStatusWindowEffectSlideVertically ) {
            [self slideVerticalEffect:YES];
        } else if ( _entryEffect == ITTransientStatusWindowEffectSlideHorizontally ) {
            [self slideHorizontalEffect:YES];
        }
    } else if ( _visibilityState == ITTransientStatusWindowVisibleState ) {
        if ( _exitEffect == ITTransientStatusWindowEffectDissolve ) {
            [self dissolveEffect:NO];
        } else if ( _exitEffect == ITTransientStatusWindowEffectSlideVertically ) {
            [self slideVerticalEffect:NO];
        } else if ( _exitEffect == ITTransientStatusWindowEffectSlideHorizontally ) {
            [self slideHorizontalEffect:NO];
        }
    }
}

- (void)dissolveEffect:(BOOL)entering
{
    if ( entering ) {
        [super orderFront:self];
    } else {
        [super orderOut:self];
    }
}

- (void)slideVerticalEffect:(BOOL)entering
{
    if ( entering ) {
        [super orderFront:self];
    } else {
        [super orderOut:self];
    }
}

- (void)slideHorizontalEffect:(BOOL)entering
{
    if ( entering ) {
        [super orderFront:self];
    } else {
        [super orderOut:self];
    }
}


@end
