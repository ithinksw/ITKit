#import "ITSpinAndZoomWindowEffect.h"
#import "ITCoreGraphicsHacks.h"
#import "ITTransientStatusWindow.h"


@interface ITSpinAndZoomWindowEffect (Private)
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)appearStep;
- (void)appearFinish;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)vanishStep;
- (void)vanishFinish;
- (void)setScale:(float)scale angle:(float)angle;
@end


@implementation ITSpinAndZoomWindowEffect


+ (NSString *)effectName
{
    return @"Spin & Zoom";
}

+ (NSDictionary *)supportedPositions
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:YES], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Top" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:YES], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Middle" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:YES], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Bottom" , nil];
}


+ (unsigned int)listOrder
{
    return 800;
}


/*************************************************************************/
#pragma mark -
#pragma mark APPEAR METHODS
/*************************************************************************/

- (void)performAppear
{
    __idle = NO;
    
    [self setWindowVisibility:ITWindowAppearingState];
    [self performAppearFromProgress:0.0 effectTime:_effectTime];
}

- (void)performAppearFromProgress:(float)progress effectTime:(float)time
{
    [_window setEffectProgress:progress];
    _effectSpeed = (1.0 / (EFFECT_FPS * time));
    
    if ( progress == 0.0 ) {
        [self setScale:0.0 angle:0.0];
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
    float interSpin = 0.0;
    [_window setEffectProgress:([_window effectProgress] + _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] < 1.0) ? [_window effectProgress] : 1.0)];
    interSpin = (( sin((([_window effectProgress]) * pi) - (pi / 2)) + 1 ) / 2);
    [self setScale:interSpin angle:-interSpin];
    [_window setAlphaValue:interSpin];

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
        [self setScale:1.0 angle:0.0];
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
    float interSpin = 1.0;
    [_window setEffectProgress:([_window effectProgress] - _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] > 0.0) ? [_window effectProgress] : 0.0)];
    interSpin = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setScale:interSpin angle:interSpin];
    [_window setAlphaValue:interSpin];

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
    [self setScale:0.0 angle:0.0];
    [self setWindowVisibility:ITWindowHiddenState];
    
    __idle = YES;
    
    if ( __shouldReleaseWhenIdle ) {
        [self release];
    }
}

- (void)cancelVanish
{
    [self setWindowVisibility:ITWindowAppearingState];
    
    [_effectTimer invalidate];
    _effectTimer = nil;
    
    [self performAppearFromProgress:[_window effectProgress] effectTime:(_effectTime / 3.5)];
}


/*************************************************************************/
#pragma mark -
#pragma mark PRIVATE METHOD IMPLEMENTATIONS
/*************************************************************************/

- (void)setScale:(float)scale angle:(float)angle
{
    //int hPos = [_window horizontalPosition];
    float radAngle = (angle * 4 * pi);
    CGAffineTransform transform;
    NSPoint translation;
    NSRect screenFrame = [[_window screen] frame];
    
    translation.x = /*screenFrame.origin.x + */([_window frame].size.width / 2.0);
    translation.y = /*screenFrame.origin.y + */([_window frame].size.height / 2.0);
    transform = CGAffineTransformMakeTranslation(translation.x, translation.y);
    transform = CGAffineTransformScale(transform, 1.0 / scale, 1.0 / scale);
    transform = CGAffineTransformRotate(transform, radAngle);
    transform = CGAffineTransformTranslate(transform, -translation.x, -translation.y);
    
    /*if (hPos == ITWindowPositionLeft) {
        translation.x = -[_window frame].origin.x;
    } else if (hPos == ITWindowPositionRight) {
        translation.x = -[_window frame].origin.x;
    } else {
        translation.x = -[_window frame].origin.x;
    }*/
    translation.x = -[_window frame].origin.x;
    translation.y = -( screenFrame.size.height - [_window frame].origin.y - [_window frame].size.height );
    
    transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          transform);
}

@end
