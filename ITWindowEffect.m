#import "ITWindowEffect.h"


@implementation ITWindowEffect


- (id)initWithWindow:(NSWindow *)window
{
    if ( (self = [super init]) ) {
    
        _window         = [window retain];
        _effectTime     = DEFAULT_EFFECT_TIME;
        _effectProgress = 0.00;
        _effectTimer    = nil;

        if ( [window conformsToProtocol:@protocol(ITWindowPositioning)] ) {
            _verticalPosition   = (ITVerticalWindowPosition)[window verticalPosition];
            _horizontalPosition = (ITHorizontalWindowPosition)[window horizontalPosition];
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
    _window = newWindow;
}

- (void)performAppear
{
    NSLog(@"ITWindowEffect does not implement performAppear.");
}

- (void)performVanish
{
    NSLog(@"ITWindowEffect does not implement performVanish.");
}

- (void)dealloc
{
	[_window release];
	[super dealloc];
}


@end
