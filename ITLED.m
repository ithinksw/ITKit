#import "ITLED.h"


/*************************************************************************/
#pragma mark -
#pragma mark CELL IMPLEMENTATION
/*************************************************************************/

@implementation ITLEDCell


/*************************************************************************/
#pragma mark -
#pragma mark CELL INITIALIZATION METHODS
/*************************************************************************/

- (id)init {
    if ( (self = [super init]) ) {
        _ledColor = [[NSColor greenColor] retain];
    }
    return self;
}


/*************************************************************************/
#pragma mark -
#pragma mark CELL INSTANCE METHODS
/*************************************************************************/

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView
{
    [[NSColor greenColor] set];
    NSRectFill(cellFrame);
}


/*************************************************************************/
#pragma mark -
#pragma mark CELL DEALLOCATION METHODS
/*************************************************************************/

- (void)dealloc {
    [super dealloc];
    [_ledColor release];
}


@end


/*************************************************************************/
#pragma mark -
#pragma mark CONTROL IMPLEMENTATION
/*************************************************************************/

@implementation ITLED


/*************************************************************************/
#pragma mark -
#pragma mark CONTROL INITIALIZATION METHODS
/*************************************************************************/

+ (void)initialize {
    if (self == [ITLED class]) {
        [self setCellClass: [ITLEDCell class]];
    }
}

+ (Class)cellClass {
    return [ITLEDCell class];
}


/*************************************************************************/
#pragma mark -
#pragma mark CONTROL INSTANCE METHODS
/*************************************************************************/

- (NSColor *)ledColor
{
    return [[self cell] ledColor];
}

- (void)setLEDColor:(NSColor *)newColor
{
    [[self cell] setLEDColor:newColor];
}


/*************************************************************************/
#pragma mark -
#pragma mark CONTROL DEALLOCATION METHODS
/*************************************************************************/

- (void)dealloc {
    [super dealloc];
}


@end
