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

+ (unsigned int)listOrder
{
    return 100;
}


/*************************************************************************/
#pragma mark -
#pragma mark APPEAR METHODS
/*************************************************************************/

- (void)performAppear
{
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
