#import "ITPivotWindowEffect.h"
#import "ITCoreGraphicsHacks.h"
#import "ITTransientStatusWindow.h"


@interface ITPivotWindowEffect (Private)
- (void)setPivot:(float)angle;
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)appearFinish;
- (void)vanishFinish;
@end


@implementation ITPivotWindowEffect

- (void)performAppear
{
    [self setWindowVisibility:ITTransientStatusWindowAppearingState];
    [self performAppearFromProgress:0.0 effectTime:_effectTime];
}

- (void)performAppearFromProgress:(float)progress effectTime:(float)time
{
    _effectProgress = progress;
    _effectSpeed = (1.0 / (EFFECT_FPS * time));
    
    if ( progress == 0.0 ) {
        [self setPivot:315.0];
        [_window setAlphaValue:0.0];
    }

    [_window orderFront:self];
    _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                    target:self
                                                  selector:@selector(appearStep)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)performVanish
{
    [self setWindowVisibility:ITTransientStatusWindowVanishingState];
    [self performVanishFromProgress:1.0 effectTime:_effectTime];
}

- (void)performVanishFromProgress:(float)progress effectTime:(float)time
{
    _effectProgress = progress;
    _effectSpeed = (1.0 / (EFFECT_FPS * time));
    if ( progress == 1.0 ) {
        [self setPivot:0.0];
        [_window setAlphaValue:1.0];
    }

    [_window orderFront:self];
    _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                    target:self
                                                  selector:@selector(vanishStep)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)cancelAppear
{
    [self setWindowVisibility:ITTransientStatusWindowVanishingState];
    
    [_effectTimer invalidate];
    _effectTimer = nil;
    
    [self performVanishFromProgress:_effectProgress effectTime:(_effectTime / 3.5)];
}

- (void)cancelVanish
{
    [self setWindowVisibility:ITTransientStatusWindowAppearingState];

    [_effectTimer invalidate];
    _effectTimer = nil;

    [self performAppearFromProgress:_effectProgress effectTime:(_effectTime / 3.5)];
}

- (void)appearStep
{
    float interPivot = 0.0;
    _effectProgress += _effectSpeed;
    _effectProgress = (_effectProgress < 1.0 ? _effectProgress : 1.0);
    interPivot = (( sin((_effectProgress * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:((interPivot * 45) + 315)];
    [_window setAlphaValue:interPivot];

    if ( _effectProgress >= 1.0 ) {
        [self appearFinish];
    }
}

- (void)vanishStep
{
    float interPivot = 1.0;
    _effectProgress -= _effectSpeed;
    _effectProgress = (_effectProgress > 0.0 ? _effectProgress : 0.0);
    interPivot = (( sin((_effectProgress * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:((interPivot * 45) + 315)];
    [_window setAlphaValue:interPivot];

    if ( _effectProgress <= 0.0 ) {
        [self vanishFinish];
    }
}

- (void)appearFinish
{
    [_effectTimer invalidate];
    _effectTimer = nil;
    [self setWindowVisibility:ITTransientStatusWindowVisibleState];
}

- (void)vanishFinish
{
    [_effectTimer invalidate];
    _effectTimer = nil;
    [self setWindowVisibility:ITTransientStatusWindowHiddenState];
}

- (void)setPivot:(float)angle
{
    float degAngle = (angle * (pi / 180));

    CGAffineTransform transform = CGAffineTransformMakeRotation(degAngle);
    
 // Set pivot rotation point
    transform.tx = -32.0;
    transform.ty = [_window frame].size.height + 32.0;

    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          CGAffineTransformTranslate(transform,
                                                     (([_window frame].origin.x - 32.0) * -1),
                                                     (([[_window screen] frame].size.height - ([_window frame].origin.y) + 32.0) * -1) ));
}


@end
