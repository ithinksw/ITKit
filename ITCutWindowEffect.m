#import "ITCutWindowEffect.h"
#import "ITTransientStatusWindow.h"
#import "ITCoreGraphicsHacks.h"

@implementation ITCutWindowEffect


+ (NSString *)effectName
{
    return @"Cut";
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


/*************************************************************************/
#pragma mark -
#pragma mark APPEAR METHODS
/*************************************************************************/

- (void)performAppear
{
    CGAffineTransform transform;
    NSPoint appearPoint;
    
    //Set the location on the screen
    if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionLeft ) {
        appearPoint.x = -( 32.0 + [[_window screen] visibleFrame].origin.x );
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionRight ) {
        appearPoint.x = -(([[_window screen] visibleFrame].size.width + [[_window screen] visibleFrame].origin.x) - 32.0 - [_window frame].size.width);
    } else if ( [(ITTransientStatusWindow *)_window horizontalPosition] == ITWindowPositionCenter ) {
        appearPoint.x = ( [_window frame].size.width - [[_window screen] visibleFrame].size.width ) / 2;
    }
    
    if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionTop ) {
        appearPoint.y = ( 64.0 + [[_window screen] visibleFrame].origin.y - [_window frame].size.height );
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionBottom ) {
        appearPoint.y = -( [[_window screen] frame].size.height - ( [_window frame].size.height + 32.0 + [[_window screen] visibleFrame].origin.y) );
    } else if ( [(ITTransientStatusWindow *)_window verticalPosition] == ITWindowPositionMiddle ) {
        appearPoint.y = ( [_window frame].size.height - [[_window screen] visibleFrame].size.height) / 2;
    }
    
    transform = CGAffineTransformMakeTranslation(appearPoint.x, appearPoint.y);
    CGSSetWindowTransform([NSApp contextID],
                          (CGSWindowID)[_window windowNumber],
                          transform);
    
    [_window orderFront:self];
    [self setWindowVisibility:ITWindowVisibleState];
}

- (void)cancelAppear
{
    [self performVanish];
}


/*************************************************************************/
#pragma mark -
#pragma mark VANISH METHODS
/*************************************************************************/

- (void)performVanish
{
    [_window orderOut:self];
    [self setWindowVisibility:ITWindowHiddenState];
}

- (void)cancelVanish
{
    [self performAppear];
}


@end
