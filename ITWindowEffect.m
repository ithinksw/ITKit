#import "ITWindowEffect.h"
#import "ITTransientStatusWindow.h"


@implementation ITWindowEffect

+ (NSArray *)effectClasses
{
    NSArray *classes = [NSArray arrayWithObjects:
        NSClassFromString(@"ITCutWindowEffect"),
        NSClassFromString(@"ITDissolveWindowEffect"),
        NSClassFromString(@"ITSlideHorizontallyWindowEffect"),
        NSClassFromString(@"ITSlideVerticallyWindowEffect"),
        NSClassFromString(@"ITPivotWindowEffect"),
        NSClassFromString(@"ITZoomWindowEffect"),
        nil];
        
    return classes;
}

- (id)initWithWindow:(NSWindow *)window
{
    if ( (self = [super init]) ) {
        _window                 = [window retain];
        _effectTime             = DEFAULT_EFFECT_TIME;
        _effectTimer            = nil;
        __shouldReleaseWhenIdle = NO;
        __idle                  = YES;

        if ( [window conformsToProtocol:@protocol(ITWindowPositioning)] ) {
            _verticalPosition   = (ITVerticalWindowPosition)[(ITTransientStatusWindow *)window verticalPosition];
            _horizontalPosition = (ITHorizontalWindowPosition)[(ITTransientStatusWindow *)window horizontalPosition];
        } else {
            NSLog(@"ITWindowEffect - initWithWindow: - window does not conform to ITWindowPositioning.");
            _verticalPosition   = ITWindowPositionBottom;
            _horizontalPosition = ITWindowPositionLeft;
        }
    }
    return self;
}

- (NSWindow *)window
{
    return _window;
}

- (void)setWindow:(NSWindow *)newWindow
{
    [_window autorelease];
    _window = [newWindow retain];
}

- (void)setWindowVisibility:(ITWindowVisibilityState)visibilityState
{
    if ( [_window conformsToProtocol:@protocol(ITWindowMotility)] ) {
       // Cast so the compiler won't gripe
        [(ITTransientStatusWindow *)_window setVisibilityState:visibilityState];
    } else {
        NSLog(@"ITWindowEffect - setWindowVisibility: - window does not conform to ITWindowVisibility.");
    }
}

- (float)effectTime
{
    return _effectTime;
}

- (void)setEffectTime:(float)newTime
{
    _effectTime = newTime;
}

+ (NSString *)effectName
{
    NSLog(@"ITWindowEffect does not implement +effectName.");
    return nil;
}

+ (NSDictionary *)supportedPositions
{
    NSLog(@"ITWindowEffect does not implement +supportedPositions.");
    
//  Below is an example dictionary.  Modify it appropriately when subclassing.
    return [NSDictionary dictionaryWithObjectsAndKeys:
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:NO], @"Right", nil] , @"Top" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:NO], @"Right", nil] , @"Middle" ,
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithBool:NO], @"Left",
            [NSNumber numberWithBool:NO], @"Center",
            [NSNumber numberWithBool:NO], @"Right", nil] , @"Bottom" , nil];
}

+ (unsigned int)listOrder
{
    NSLog(@"ITWindowEffect does not implement +listOrder.");
    return 0;
}

- (void)performAppear
{
    NSLog(@"ITWindowEffect does not implement -performAppear.");
}

- (void)performVanish
{
    NSLog(@"ITWindowEffect does not implement -performVanish.");
}

- (void)cancelAppear
{
    NSLog(@"ITWindowEffect does not implement -cancelAppear.");
}

- (void)cancelVanish
{
    NSLog(@"ITWindowEffect does not implement -cancelVanish.");
}

- (void)releaseWhenIdle;
{
    if ( __idle ) {
        [self release];
    } else {
        __shouldReleaseWhenIdle = YES;
    }
}

- (void)dealloc
{
	[_window release];
	[super dealloc];
}


@end
