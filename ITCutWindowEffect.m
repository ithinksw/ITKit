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
    [self setWindowVisibility:ITTransientStatusWindowVisibleState];
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
    [self setWindowVisibility:ITTransientStatusWindowHiddenState];
}

- (void)cancelVanish
{
    [self performAppear];
}


@end
