#import "ITCutWindowEffect.h"
#import "ITTransientStatusWindow.h"


@implementation ITCutWindowEffect


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
