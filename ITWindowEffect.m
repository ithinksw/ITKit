#import "ITWindowEffect.h"
#import "ITTransientStatusWindow.h"


@implementation ITWindowEffect


- (id)initWithWindow:(NSWindow *)window
{
    if ( (self = [super init]) ) {
    
        _window         = [window retain];
        _effectTime     = DEFAULT_EFFECT_TIME;
        _effectTimer    = nil;

        if ( [window conformsToProtocol:@protocol(ITWindowPositioning)] ) {
                                                           // Casts so the compiler won't gripe
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

- (void)performAppear
{
    NSLog(@"ITWindowEffect does not implement performAppear.");
}

- (void)performVanish
{
    NSLog(@"ITWindowEffect does not implement performVanish.");
}

- (void)cancelAppear
{
    NSLog(@"ITWindowEffect does not implement cancelAppear.");
}

- (void)cancelVanish
{
    NSLog(@"ITWindowEffect does not implement cancelVanish.");
}

- (void)dealloc
{
	[_window release];
	[super dealloc];
}


@end
