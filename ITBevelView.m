#import "ITBevelView.h"


@implementation ITBevelView


/*************************************************************************/
#pragma mark -
#pragma mark INITIALIZATION METHODS
/*************************************************************************/

- (id)initWithFrame:(NSRect)frameRect
{
    if ( (self = [super initWithFrame:frameRect]) ) {
        _bevelDepth = 5;
        [self setAutoresizesSubviews:NO];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
    if ( ( self = [super initWithCoder:coder] ) ) {
        _bevelDepth = 5;
        [self setAutoresizesSubviews:NO];
    }

    return self;
}


/*************************************************************************/
#pragma mark -
#pragma mark ACCESSOR METHODS
/*************************************************************************/

- (int)bevelDepth
{
    return _bevelDepth;
}

- (void)setBevelDepth:(int)newDepth
{
    _bevelDepth = newDepth;
    [self setNeedsDisplay:YES];
}


/*************************************************************************/
#pragma mark -
#pragma mark INSTANCE METHODS
/*************************************************************************/

- (void)drawRect:(NSRect)aRect
{
        // Draw special bezel, with a thickness of _bevelDepth.
    NSRect innerRect = NSMakeRect( (aRect.origin.x + _bevelDepth),
                                   (aRect.origin.y + _bevelDepth),
                                   (aRect.size.width  - (_bevelDepth * 2)),
                                   (aRect.size.height - (_bevelDepth * 2)) );

    NSBezierPath *leftEdge   = [NSBezierPath bezierPath];
    NSBezierPath *topEdge    = [NSBezierPath bezierPath];
    NSBezierPath *rightEdge  = [NSBezierPath bezierPath];
    NSBezierPath *bottomEdge = [NSBezierPath bezierPath];

    [[[self subviews] objectAtIndex:0] setFrame:innerRect];

    [leftEdge moveToPoint:aRect.origin];
    [leftEdge lineToPoint:NSMakePoint(aRect.origin.x, aRect.size.height)];
    [leftEdge lineToPoint:NSMakePoint( (aRect.origin.x + _bevelDepth), (aRect.size.height - _bevelDepth) )];
    [leftEdge lineToPoint:NSMakePoint( (aRect.origin.x + _bevelDepth), (aRect.origin.y + _bevelDepth) )];

    [topEdge moveToPoint:NSMakePoint(aRect.origin.x, aRect.size.height)];
    [topEdge lineToPoint:NSMakePoint(aRect.size.width, aRect.size.height)];
    [topEdge lineToPoint:NSMakePoint( (aRect.size.width - _bevelDepth), (aRect.size.height - _bevelDepth) )];
    [topEdge lineToPoint:NSMakePoint( (aRect.origin.x + _bevelDepth), (aRect.size.height - _bevelDepth) )];

    [rightEdge moveToPoint:NSMakePoint(aRect.size.width, aRect.origin.y)];
    [rightEdge lineToPoint:NSMakePoint(aRect.size.width, aRect.size.height)];
    [rightEdge lineToPoint:NSMakePoint( (aRect.size.width - _bevelDepth), (aRect.size.height - _bevelDepth) )];
    [rightEdge lineToPoint:NSMakePoint( (aRect.size.width - _bevelDepth), (_bevelDepth) )];

    [bottomEdge moveToPoint:aRect.origin];
    [bottomEdge lineToPoint:NSMakePoint(aRect.size.width, aRect.origin.y)];
    [bottomEdge lineToPoint:NSMakePoint( (aRect.size.width - _bevelDepth), (_bevelDepth) )];
    [bottomEdge lineToPoint:NSMakePoint( (aRect.origin.x + _bevelDepth), (aRect.origin.y + _bevelDepth) )];

    [[NSColor colorWithCalibratedWhite:0.5 alpha:0.5] set];
    [leftEdge fill];
    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.5] set];
    [topEdge fill];
    [[NSColor colorWithCalibratedWhite:0.5 alpha:0.5] set];
    [rightEdge fill];
    [[NSColor colorWithCalibratedWhite:1.0 alpha:0.6] set];
    [bottomEdge fill];
}


/*************************************************************************/
#pragma mark -
#pragma mark DEALLOCATION METHOD
/*************************************************************************/

- (void)dealloc
{
	[super dealloc];
}


@end
