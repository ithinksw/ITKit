#import "ITWindowEffect.h"
#import "ITTransientStatusWindow.h"


@implementation ITWindowEffect

+ (NSArray *)effectsInfo
{
    int ce;
    NSMutableArray *finalArray = [[[NSMutableArray alloc] initWithCapacity:5] autorelease];

    NSArray *effectKeys = [NSArray arrayWithObjects:
        @"Name",
        @"Class",
        @"Positions",
        nil];
    
    NSArray *effectNames = [NSArray arrayWithObjects:
        @"Cut",
        @"Dissolve",
        @"Slide Horizontally",
        @"Slide Vertically",
        @"Pivot",
        nil];
        
    NSArray *classNames = [NSArray arrayWithObjects:
        @"ITCutWindowEffect",
        @"ITDissolveWindowEffect",
        @"ITSlideHorizontallyWindowEffect",
        @"ITSlideVerticallyWindowEffect",
        @"ITPivotWindowEffect",
        nil];
        
    NSArray *positionKeys = [NSArray arrayWithObjects:
        @"TopLeft",
        @"TopCenter",
        @"TopRight",
        @"MiddleLeft",
        @"MiddleCenter",
        @"MiddleRight",
        @"BottomLeft",
        @"BottomCenter",
        @"BottomRight",
        nil];
        
    NSArray *cutPositionValues = [NSArray arrayWithObjects:
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        nil];
    
    NSArray *dissolvePositionValues = [NSArray arrayWithObjects:
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        nil];
    
    NSArray *slideVerticallyPositionValues = [NSArray arrayWithObjects:
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        nil];
    
    NSArray *slideHorizontallyPositionValues = [NSArray arrayWithObjects:
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        nil];
    
    NSArray *pivotPositionValues = [NSArray arrayWithObjects:
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        [NSNumber numberWithBool:NO],
        [NSNumber numberWithBool:YES],
        nil];
    
    NSArray *positionDicts = [NSArray arrayWithObjects:
        [NSDictionary dictionaryWithObjects:cutPositionValues
                                    forKeys:positionKeys],
        [NSDictionary dictionaryWithObjects:dissolvePositionValues
                                    forKeys:positionKeys],
        [NSDictionary dictionaryWithObjects:slideVerticallyPositionValues
                                    forKeys:positionKeys],
        [NSDictionary dictionaryWithObjects:slideHorizontallyPositionValues
                                    forKeys:positionKeys],
        [NSDictionary dictionaryWithObjects:pivotPositionValues
                                    forKeys:positionKeys],
        nil];
        
    for ( ce = 0 ; ce < [effectNames count] ; ce++ ) {
        
        NSArray *entryValues = [NSArray arrayWithObjects:
            [effectNames   objectAtIndex:ce],
            [classNames    objectAtIndex:ce],
            [positionDicts objectAtIndex:ce],
            nil];
        
        NSDictionary *entryDict = [NSDictionary dictionaryWithObjects:entryValues
                                                              forKeys:effectKeys];
        [finalArray addObject:entryDict];
    }
    
    return finalArray;
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
