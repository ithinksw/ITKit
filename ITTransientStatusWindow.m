#import "ITTransientStatusWindow.h"
#import <CoreGraphics/CoreGraphics.h>
#import "ITCoreGraphicsHacks.h"
#import "ITTextField.h"
#import "ITGrayRoundedView.h"


#define EFFECT_FPS 30.0


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
- (void)dissolveEffect;
- (void)slideVerticalEffect;
- (void)slideHorizontalEffect;
- (void)pivotEffect;
- (void)pivotStep;
- (void)pivotFinish;
- (void)setPivot:(float)angle;
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
    
    // If no Content View was provided, use a generic NSView with the app icon.
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
        _verticalPosition    = ITTransientStatusWindowPositionBottom;
        _horizontalPosition  = ITTransientStatusWindowPositionLeft;
//      _entryEffect         = ITTransientStatusWindowEffectNone;
        _entryEffect         = ITTransientStatusWindowEffectPivot;
        _exitEffect          = ITTransientStatusWindowEffectDissolve;
        _effectTime          = DEFAULT_EFFECT_TIME;
        _effectProgress      = 0.00;
        _reallyIgnoresEvents = YES;
        _delayTimer          = nil;
        _effectTimer         = nil;

//        if ( _backgroundType == ITTransientStatusWindowRounded ) {
//            _contentSubView = contentView;
//        } else {
//            [self setContentView:contentView];
//        }

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

- (void)orderFront:(id)sender
{
    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
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

    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
        [super makeKeyAndOrderFront:sender];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [self performEffect];
        [self makeKeyWindow];
    }
}

- (void)orderOut:(id)sender
{
    if ( _entryEffect == ITTransientStatusWindowEffectNone ) {
        [super orderOut:sender];
        _visibilityState = ITTransientStatusWindowHiddenState;
    } else {
        [self performEffect];
    }
}

- (NSTimeInterval)animationResizeTime:(NSRect)newFrame
{
    return _effectTime;
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

- (void)dissolveEffect
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        [super orderFront:self];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [super orderOut:self];
        _visibilityState = ITTransientStatusWindowHiddenState;
    }
}

- (void)slideVerticalEffect
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        [super orderFront:self];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [super orderOut:self];
        _visibilityState = ITTransientStatusWindowHiddenState;
    }
}

- (void)slideHorizontalEffect
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        [super orderFront:self];
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        [super orderOut:self];
        _visibilityState = ITTransientStatusWindowHiddenState;
    }
}

- (void)pivotEffect
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        [self setPivot:315.0];
        _effectProgress = 0.0;
        [self setAlphaValue:0.0];
        [super orderFront:self];
        _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                        target:self
                                                      selector:@selector(pivotStep)
                                                      userInfo:nil
                                                       repeats:YES];
    } else {
        [super orderOut:self];
        _visibilityState = ITTransientStatusWindowHiddenState;
    }
}

- (void)pivotStep
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        float interPivot = 0.0;
        _effectProgress += (1.0 / (EFFECT_FPS * _effectTime));
        _effectProgress = (_effectProgress < 1.0 ? _effectProgress : 1.0);
        interPivot = (( sin((_effectProgress * pi) - (pi / 2)) + 1 ) / 2);
        [self setPivot:((interPivot * 45) + 315)];
        [self setAlphaValue:interPivot];
        if ( _effectProgress >= 1.0 ) {
            [self pivotFinish];
        }
    } else {
        //backwards
    }
}

- (void)pivotFinish
{
    if ( _visibilityState == ITTransientStatusWindowEnteringState ) {
        [_effectTimer invalidate];
        _effectTimer = nil;
        _effectProgress = 0.0;
        _visibilityState = ITTransientStatusWindowVisibleState;
    } else {
        //backwards
    }
}


- (void)setPivot:(float)angle
{
    float degAngle = (angle * (pi / 180));
    CGAffineTransform transform = CGAffineTransformMakeRotation(degAngle);
    transform.tx = -32.0;
    transform.ty = [self frame].size.height + 32.0;
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[self windowNumber],
                          CGAffineTransformTranslate(transform,
                                                     (([self frame].origin.x - 32.0) * -1),
                                                     (([[self screen] frame].size.height - ([self frame].origin.y) + 32.0) * -1) ));
}

@end
