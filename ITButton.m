#import "ITButton.h"
#import "ITButtonCell.h"


@implementation ITButton


/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

+ (void)initialize
{
    if ( self == [ITButton class] ) {
        [self setCellClass:[ITButtonCell class]];
    }
}

+ (Class)cellClass
{
    return [ITButtonCell class];
}

- (void)displayIfNeeded {
    [self displayIfNeededIgnoringOpacity];
}

- (void)displayIfNeededInRect:(NSRect)aRect {
    [self displayIfNeededInRectIgnoringOpacity:aRect];
}

- (void)displayRect:(NSRect)aRect {
    [self displayRectIgnoringOpacity:aRect];
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ( ( self = [super initWithCoder:coder] ) ) {
        ITButtonCell *cell = [[ITButtonCell alloc] init];
        [self setCell:cell];
    }
    return self;
}

- (BOOL)isOpaque
{
    return NO;
}

@end
