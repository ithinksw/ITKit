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


+ (unsigned int)listOrder
{
    return 500;
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
    float progress   = ([_window effectProgress] + _effectSpeed);
    
    progress = ( (progress < 1.0) ? progress : 1.0 );
    
    [_window setEffectProgress:progress];
    
    interPivot = (( sin((progress * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:(315 + (interPivot * 45))];
    [_window setAlphaValue:interPivot];
    
    if ( progress >= 1.0 ) {
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
    float progress   = ([_window effectProgress] - _effectSpeed);
    
    progress = ( (progress > 0.0) ? progress : 0.0);
    
    [_window setEffectProgress:progress];
    
    interPivot = (( sin(([_window effectProgress] * pi) - (pi / 2)) + 1 ) / 2);
    [self setPivot:(315 + (interPivot * 45))];
    [_window setAlphaValue:interPivot];
    
    if ( progress <= 0.0 ) {
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
    int hPos = [_window horizontalPosition];
    int vPos = [_window verticalPosition];
	NSRect winFrame = [_window frame];

    if ( (hPos == ITWindowPositionCenter) || (vPos == ITWindowPositionMiddle) ) {
    
        CGAffineTransform transform;
        NSPoint translation;
        
        translation.x = -winFrame.origin.x;
        translation.y = winFrame.origin.y + winFrame.size.height - [[NSScreen mainScreen] frame].size.height;

        transform = CGAffineTransformMakeTranslation( translation.x, translation.y );
        
        CGSSetWindowTransform([NSApp contextID],
                              (CGSWindowID)[_window windowNumber],
                              transform);
    } else {
        
        float  degAngle;
        NSRect screenFrame = [[_window screen] frame];
        float  translateX = 0;
        float  translateY = 0;
        CGAffineTransform transform;
        
        if ( vPos == ITWindowPositionBottom ) {
            if ( hPos == ITWindowPositionLeft ) {
                angle = angle;
            } else if ( hPos == ITWindowPositionRight ) {
                angle = ( 45 - -(315 - angle) );
            }
        } else if ( vPos == ITWindowPositionTop ) {
            if ( hPos == ITWindowPositionLeft ) {
                angle = ( 45 - -(315 - angle) );
            } else if ( hPos == ITWindowPositionRight ) {
                angle = angle;
            }
        }
        
        degAngle  = (angle * (pi / 180));
        transform = CGAffineTransformMakeRotation(degAngle);
        if ( vPos == ITWindowPositionBottom ) {
            transform.ty = ( winFrame.size.height + winFrame.origin.y) + (screenFrame.size.height - [[NSScreen mainScreen] frame].size.height);
            translateY   = -(screenFrame.size.height);
        } else if ( vPos == ITWindowPositionTop ) {
			transform.ty = winFrame.origin.y + winFrame.size.height - [[NSScreen mainScreen] frame].size.height;
            translateY   = 0;
        }
        
        if ( hPos == ITWindowPositionLeft ) {
            transform.tx = -( winFrame.origin.x );
            translateX   = 0;
        } else if ( hPos == ITWindowPositionRight ) {
            //transform.tx = ( screenFrame.size.width - winFrame.origin.x );
			transform.tx = ( screenFrame.size.width - winFrame.origin.x );
            translateX   = -(screenFrame.size.width);
        }
        CGSSetWindowTransform([NSApp contextID],
                              (CGSWindowID)[_window windowNumber],
                              CGAffineTransformTranslate( transform,
                                                          translateX,
                                                          translateY ) );
    }
}


@end
