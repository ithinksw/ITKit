#import "ITPivotWindowEffect.h"
#import "ITCoreGraphicsHacks.h"

@implementation ITPivotWindowEffect


- (void)performAppear
{
    NSLog(@"ITPivotWindowEffect does not implement performAppear.");
}

- (void)performVanish
{
    NSLog(@"ITPivotWindowEffect does not implement performVanish.");
}

- (void)pivotEffect
{
    if ( YES ) {
        [self setPivot:315.0];
        _effectProgress = 0.0;
        [_window setAlphaValue:0.0];
        [_window orderFront:self];
        _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                        target:self
                                                      selector:@selector(pivotStep)
                                                      userInfo:nil
                                                       repeats:YES];
    } else {
        [_window orderOut:self];
    }
}

- (void)pivotStep
{
    if ( YES ) {
        float interPivot = 0.0;
        _effectProgress += (1.0 / (EFFECT_FPS * _effectTime));
        _effectProgress = (_effectProgress < 1.0 ? _effectProgress : 1.0);
        interPivot = (( sin((_effectProgress * pi) - (pi / 2)) + 1 ) / 2);
        [self setPivot:((interPivot * 45) + 315)];
        [_window setAlphaValue:interPivot];
        if ( _effectProgress >= 1.0 ) {
            [self pivotFinish];
        }
    } else {
        //backwards
    }
}

- (void)pivotFinish
{
    if ( YES ) {
        [_effectTimer invalidate];
        _effectTimer = nil;
        _effectProgress = 0.0;
    } else {
        //backwards
    }
}


- (void)setPivot:(float)angle
{
    float degAngle = (angle * (pi / 180));
    CGAffineTransform transform = CGAffineTransformMakeRotation(degAngle);
    
 // Set pivot point
    transform.tx = -32.0;
    transform.ty = [_window frame].size.height + 32.0;

    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          CGAffineTransformTranslate(transform,
                                                     (([_window frame].origin.x - 32.0) * -1),
                                                     (([[_window screen] frame].size.height - ([_window frame].origin.y) + 32.0) * -1) ));
}


@end
