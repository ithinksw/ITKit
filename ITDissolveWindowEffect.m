#import "ITDissolveWindowEffect.h"
#import "ITTransientStatusWindow.h"
#import "ITCoreGraphicsHacks.h"

@interface ITDissolveWindowEffect (Private)
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)appearStep;
- (void)appearFinish;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)vanishStep;
- (void)vanishFinish;
@end


@implementation ITDissolveWindowEffect


/*************************************************************************/
#pragma mark -
#pragma mark APPEAR METHODS
/*************************************************************************/

- (void)performAppear
{
    CGAffineTransform transform;
    NSPoint appearPoint;
    __idle = NO;
    
    //Set the location on the screen
    if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) {
        appearPoint.x = -( 32.0 + [[_window screen] visibleFrame].origin.x );
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionRight ) {
        appearPoint.x = -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 32.0 - [_window frame].size.width);
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionCenter ) {
        appearPoint.x = ( [_window frame].size.width - [[_window screen] visibleFrame].size.width ) / 2;
    }
    
    if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
        appearPoint.y = ( 64.0 + [[_window screen] visibleFrame].origin.y - [_window frame].size.height );
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
        appearPoint.y = -( [[_window screen] frame].size.height - ( [_window frame].size.height + 32.0 + [[_window screen] visibleFrame].origin.y) );
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionMiddle ) {
        appearPoint.y = ( [_window frame].size.height - [[_window screen] visibleFrame].size.height) / 2;
    }
    
    transform = CGAffineTransformMakeTranslation(appearPoint.x, appearPoint.y);
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          transform);
    
    [self setWindowVisibility:ITWindowAppearingState];
    [self performAppearFromProgress:0.0 effectTime:_effectTime];
}

- (void)performAppearFromProgress:(float)progress effectTime:(float)time
{
    [_window setEffectProgress:progress];
    _effectSpeed = (1.0 / (EFFECT_FPS * time));

    if ( progress == 0.0 ) {
        [_window setAlphaValue:0.0];
    }

    [_window orderFront:self];
    _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                    target:self
                                                  selector:@selector(appearStep)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)appearStep
{
    float interFade = 0.0;
    [_window setEffectProgress:([_window effectProgress] + _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] < 1.0) ? [_window effectProgress] : 1.0)];
    interFade = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [_window setAlphaValue:interFade];

    if ( [_window effectProgress] >= 1.0 ) {
        [self appearFinish];
    }
}

- (void)appearFinish
{
    [_effectTimer invalidate];
    _effectTimer = nil;
    [self setWindowVisibility:ITWindowVisibleState];

    __idle = YES;
    
    if ( __shouldReleaseWhenIdle ) {
        [self release];
    }
}

- (void)cancelAppear
{
    [self setWindowVisibility:ITWindowVanishingState];

    [_effectTimer invalidate];
    _effectTimer = nil;

    [self performVanishFromProgress:[_window effectProgress] effectTime:(_effectTime / 3.5)];
}


/*************************************************************************/
#pragma mark -
#pragma mark VANISH METHODS
/*************************************************************************/

- (void)performVanish
{
    __idle = NO;
    
    [self setWindowVisibility:ITWindowVanishingState];
    [self performVanishFromProgress:1.0 effectTime:_effectTime];
}

- (void)performVanishFromProgress:(float)progress effectTime:(float)time
{
    [_window setEffectProgress:progress];
    _effectSpeed = (1.0 / (EFFECT_FPS * time));
    if ( progress == 1.0 ) {
        [_window setAlphaValue:1.0];
    }

    [_window orderFront:self];
    _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                    target:self
                                                  selector:@selector(vanishStep)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)vanishStep
{
    float interFade = 1.0;
    [_window setEffectProgress:([_window effectProgress] - _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] > 0.0) ? [_window effectProgress] : 0.0)];
    interFade = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [_window setAlphaValue:interFade];

    if ( [_window effectProgress] <= 0.0 ) {
        [self vanishFinish];
    }
}

- (void)vanishFinish
{
    [_effectTimer invalidate];
    _effectTimer = nil;
    [_window orderOut:self];
    [_window setAlphaValue:1.0];
    [self setWindowVisibility:ITWindowHiddenState];

    __idle = YES;
    
    if ( __shouldReleaseWhenIdle ) {
        [self release];
    }
}

- (void)cancelVanish
{
    [self setWindowVisibility:ITWindowVanishingState];

    [_effectTimer invalidate];
    _effectTimer = nil;

    [self performAppearFromProgress:[_window effectProgress] effectTime:(_effectTime / 3.5)];
}


@end
