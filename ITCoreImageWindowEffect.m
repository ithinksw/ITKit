#import "ITCoreImageWindowEffect.h"
#import "ITTransientStatusWindow.h"
#import "ITCoreGraphicsHacks.h"
#import "ITCoreImageView.h"

@interface ITCoreImageWindowEffect (Private)
- (void)performAppearFromProgress:(float)progress effectTime:(float)time;
- (void)appearStep;
- (void)appearFinish;
- (void)performVanishFromProgress:(float)progress effectTime:(float)time;
- (void)vanishStep;
- (void)vanishFinish;

- (void)setupEffect;
@end

static BOOL _running = NO;

@implementation ITCoreImageWindowEffect

+ (NSString *)effectName
{
    return @"Ripple";
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
        [_window setAlphaValue:0.0];
    }
	
	[_window orderFront:self];
	
    _effectTimer = [NSTimer scheduledTimerWithTimeInterval:(1.0 / EFFECT_FPS)
                                                    target:self
                                                  selector:@selector(appearStep)
                                                  userInfo:nil
                                                   repeats:YES];
	[self setupEffect];
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
	[self setupEffect];
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

/*************************************************************************/
#pragma mark -
#pragma mark CORE IMAGE METHODS
/*************************************************************************/

- (void)setupEffect
{
	NSRect rippleRect = [_window frame];
	NSRect screenRect = [[_window screen] frame];
	
	if (_running) {
		//Short-circuit to avoid layering effects and crashing
		return;
	}
	
	_running = YES;
	_ripple = YES;
	
    rippleRect.origin.y = - (NSMaxY(rippleRect) - screenRect.size.height);
	
	_effectWindow = [[NSWindow alloc] initWithContentRect:_ripple ? NSInsetRect([_window frame], -200, -200) : [_window frame] styleMask:NSBorderlessWindowMask backing:NSBackingStoreBuffered defer:NO];
	[_effectWindow setBackgroundColor:[NSColor clearColor]];
	[_effectWindow setAlphaValue:1.0];
	[_effectWindow setOpaque:NO];
	[_effectWindow setHasShadow:NO];
	[_effectWindow setContentView:[[ITCoreImageView alloc] initWithFrame:[_window frame]]];
	[_effectWindow setLevel:[_window level]];
	
	[_effectWindow orderFrontRegardless];
    [_window orderWindow:NSWindowAbove relativeTo:[_effectWindow windowNumber]];
	
	if (_ripple) {
		_effectFilter = [[CIFilter filterWithName:@"CIShapedWaterRipple"] retain];
		[_effectFilter setDefaults];
		[_effectFilter setValue:[NSNumber numberWithFloat:50.0] forKey:@"inputCornerRadius"];
		[_effectFilter setValue:[CIVector vectorWithX:rippleRect.origin.x Y:rippleRect.origin.y] forKey:@"inputPoint0"];
		[_effectFilter setValue:[CIVector vectorWithX:(rippleRect.origin.x + rippleRect.size.width) Y:(rippleRect.origin.y + rippleRect.size.height)] forKey:@"inputPoint1"];
		[_effectFilter setValue:[NSNumber numberWithFloat:0.0] forKey:@"inputPhase"];
	} else {
		_effectFilter = [[CIFilter filterWithName:@"CIZoomBlur"] retain];
		[_effectFilter setDefaults];
		[_effectFilter setValue:[CIVector vectorWithX:(rippleRect.origin.x + rippleRect.size.width / 2) Y:(rippleRect.origin.y + rippleRect.size.height / 2)] forKey:@"inputCenter"];
	}
	
	_windowFilter = [[CICGSFilter filterWithFilter:_effectFilter connectionID:[NSApp contextID]] retain];
	[_windowFilter addToWindow:(CGSWindowID)[_effectWindow windowNumber] flags:1];
	
	[NSThread detachNewThreadSelector:@selector(runFilterAnimation:) toTarget:self withObject:self];
}

- (void)runFilterAnimation:(id)sender
{
	NSAutoreleasePool *pool;
    CICGSFilter *oldFilter;
    CFAbsoluteTime startTime, time;
	CGSWindowID windowNumber = (CGSWindowID)[_effectWindow windowNumber];
    
    pool = [[NSAutoreleasePool alloc] init];
	
    startTime = CFAbsoluteTimeGetCurrent();
    time = CFAbsoluteTimeGetCurrent();
	
	while (time < (startTime + 2.5) && (time >= startTime)) {
		oldFilter = _windowFilter;
		if (_ripple) {
			[_effectFilter setValue:[NSNumber numberWithFloat:160*(time - startTime)] forKey:@"inputPhase"];
		} else {
			[_effectFilter setValue:[NSNumber numberWithFloat:5 * (time - startTime)] forKey:@"inputAmount"];
		}
        _windowFilter = [[CICGSFilter filterWithFilter:_effectFilter connectionID:[NSApp contextID]] retain];
        [_windowFilter addToWindow:windowNumber flags:1];
		[oldFilter removeFromWindow:windowNumber];
		[oldFilter release];
        time = CFAbsoluteTimeGetCurrent();
	}
	
	[_windowFilter removeFromWindow:windowNumber];
	[_windowFilter release];
    [_effectFilter release];
    [_effectWindow orderOut:self];
	[[_effectWindow contentView] release];
    [_effectWindow release];
    [pool release];
	
	_running = NO;
}

@end
