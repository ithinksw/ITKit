#import "ITSlideVerticallyWindowEffect.h"
#import "ITCoreGraphicsHacks.h"
#import "ITTransientStatusWindow.h"


@interface ITSlideVerticallyWindowEffect (Private)
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)appearStep;
- (void)appearFinish;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)vanishStep;
- (void)vanishFinish;
- (void)setSlide:(float)distance;
@end


@implementation ITSlideVerticallyWindowEffect


+ (NSString *)effectName
{
    return @"Slide Vertically";
}

+ (NSDictionary *)supportedPositions
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:YES], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Top" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:NO], @"Right", nil] , @"Middle" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:YES], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Bottom" , nil];
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
    float interSlide = 0.0;
    [_window setEffectProgress:([_window effectProgress] + _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] < 1.0) ? [_window effectProgress] : 1.0)];
    interSlide = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setSlide:(interSlide * [_window frame].size.height)];
    [_window setAlphaValue:interSlide];

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

    [self performVanishFromProgress:[_window effectProgress] effectTime:(_effectTime / 4.0)];
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
    float interSlide = 1.0;
    [_window setEffectProgress:([_window effectProgress] - _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] > 0.0) ? [_window effectProgress] : 0.0)];
    interSlide = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setSlide:(interSlide * [_window frame].size.height)];
    [_window setAlphaValue:interSlide];

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
    [self setSlide:[_window frame].size.height];
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

    [self performAppearFromProgress:[_window effectProgress] effectTime:(_effectTime / 4.0)];
}

- (void)setSlide:(float)distance
{
    CGAffineTransform transform;
    float xPoint;
    
    if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) {
        xPoint = -( 32.0 + [[_window screen] visibleFrame].origin.x );
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionRight ) {
        xPoint = -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 32.0 - [_window frame].size.width);
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionCenter ) {
        xPoint = ( [_window frame].size.width - [[_window screen] visibleFrame].size.width ) / 2;
    }
    
    /*if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
        transform = CGAffineTransformMakeTranslation( ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) ? -( 32.0 + [[_window screen] visibleFrame].origin.x ) : -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 32.0 - [_window frame].size.width),
                                                    -( [[_window screen] frame].size.height - ( distance + 32.0 + [[_window screen] visibleFrame].origin.y ) ) );
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
        transform = CGAffineTransformMakeTranslation( ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) ? -( 32.0 + [[_window screen] visibleFrame].origin.x ) : -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 32.0 - [_window frame].size.width),
                                                    [[_window screen] visibleFrame].origin.y - distance + 64.0 );
    }*/
    
    transform = CGAffineTransformMakeTranslation(xPoint,
                                                 ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) ? ( [[_window screen] visibleFrame].origin.y - distance + 64.0 ) : -( [[_window screen] frame].size.height - ( distance + 32.0 + [[_window screen] visibleFrame].origin.y ) ) );
    
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          transform);
}
@end
