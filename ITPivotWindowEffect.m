#import "ITPivotWindowEffect.h"
#import "ITCoreGraphicsHacks.h"
#import "ITTransientStatusWindow.h"


@interface ITPivotWindowEffect (Private)
- (void)setPivot:(float)angle;
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)appearStep;
- (void)appearFinish;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)vanishStep;
- (void)vanishFinish;
@end


@implementation ITPivotWindowEffect


+ (NSString *)effectName
{
    return @"Pivot";
}

+ (NSDictionary *)supportedPositions
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:YES], @"Right", nil] , @"Top" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:NO], @"Right", nil] , @"Middle" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:YES], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
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

- (void)appearStep
{
    float interPivot = 0.0;
    [_window setEffectProgress:([_window effectProgress] + _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] < 1.0) ? [_window effectProgress] : 1.0)];
    interPivot = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:((interPivot * 45) + 315)];
    [_window setAlphaValue:interPivot];

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

- (void)vanishStep
{
    float interPivot = 1.0;
    [_window setEffectProgress:([_window effectProgress] - _effectSpeed)];
    [_window setEffectProgress:( ([_window effectProgress] > 0.0) ? [_window effectProgress] : 0.0)];
    interPivot = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:((interPivot * 45) + 315)];
    [_window setAlphaValue:interPivot];

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
    [self setPivot:0.0];
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

- (void)setPivot:(float)angle
{
    float degAngle;
    NSPoint appearPoint;
    CGAffineTransform transform;
    
    if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) {
        if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
            degAngle = (angle * (pi / 180));
        } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
            degAngle = (-angle * (pi / 180));
        }
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionRight ) {
        if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
            degAngle = (angle * (pi / 180));
        } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
            degAngle = (angle * (pi / 180));
        }
    }
    
    transform = CGAffineTransformMakeRotation(degAngle);
    
 // Set pivot rotation point
    //transform.tx = -( 32.0 + [[_window screen] visibleFrame].origin.x );
    transform.ty = ( [_window frame].size.height + 32.0 + [[_window screen] visibleFrame].origin.y );
    
    if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) {
        appearPoint.x = -( 32.0 + [[_window screen] visibleFrame].origin.x );
        transform.tx = -( 32.0 + [[_window screen] visibleFrame].origin.x );
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionRight ) {
        transform.tx = -( 32.0 + [[_window screen] visibleFrame].origin.x ) + [_window frame].size.width;
        appearPoint.x = -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 64.0);
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionCenter ) {
        appearPoint.x = ( [_window frame].size.width - [[_window screen] visibleFrame].size.width ) / 2;
    }
    
    if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
        appearPoint.y = ( [_window frame].size.height - [[_window screen] visibleFrame].size.height) / 2;
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
        appearPoint.y = -( [[_window screen] frame].size.height - ([_window frame].origin.y) + 32.0 + [[_window screen] visibleFrame].origin.y) ;
    }/* else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionMiddle ) {
        appearPoint.y = ( [_window frame].size.height - [[_window screen] visibleFrame].size.height) / 2;
    }*/
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          CGAffineTransformTranslate( transform,
                                                     appearPoint.x,
                                                     appearPoint.y ) );
}

@end
