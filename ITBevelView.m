#import "ITBevelView.h"

@implementation ITBevelView

- (id)initWithFrame:(NSRect)frameRect {
	if ((self = [super initWithFrame:frameRect])) {
		_bevelDepth = 5;
		[self setAutoresizesSubviews:NO];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder {
	if ((self = [super initWithCoder:coder])) {
		_bevelDepth = 5;
		[self setAutoresizesSubviews:NO];
	}
	return self;
}

- (int)bevelDepth {
	return _bevelDepth;
}

- (void)setBevelDepth:(int)newDepth {
	_bevelDepth = newDepth;
	[self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)aRect {
	NSRect frameRect = [self convertRect:[self frame] fromView:[self superview]];
	NSRect innerRect = NSMakeRect((frameRect.origin.x + _bevelDepth), (frameRect.origin.y + _bevelDepth), (frameRect.size.width - (_bevelDepth * 2)), (frameRect.size.height - (_bevelDepth * 2)));

	NSBezierPath *leftEdge = [NSBezierPath bezierPath];
	NSBezierPath *topEdge = [NSBezierPath bezierPath];
	NSBezierPath *rightEdge = [NSBezierPath bezierPath];
	NSBezierPath *bottomEdge = [NSBezierPath bezierPath];

	[[[self subviews] objectAtIndex:0] setFrame:innerRect];

	[leftEdge moveToPoint:frameRect.origin];
	[leftEdge lineToPoint:NSMakePoint(frameRect.origin.x, frameRect.size.height)];
	[leftEdge lineToPoint:NSMakePoint((frameRect.origin.x + _bevelDepth), (frameRect.size.height - _bevelDepth))];
	[leftEdge lineToPoint:NSMakePoint((frameRect.origin.x + _bevelDepth), (frameRect.origin.y + _bevelDepth))];

	[topEdge moveToPoint:NSMakePoint(frameRect.origin.x, frameRect.size.height)];
	[topEdge lineToPoint:NSMakePoint(frameRect.size.width, frameRect.size.height)];
	[topEdge lineToPoint:NSMakePoint((frameRect.size.width - _bevelDepth), (frameRect.size.height - _bevelDepth))];
	[topEdge lineToPoint:NSMakePoint((frameRect.origin.x + _bevelDepth), (frameRect.size.height - _bevelDepth))];

	[rightEdge moveToPoint:NSMakePoint(frameRect.size.width, frameRect.origin.y)];
	[rightEdge lineToPoint:NSMakePoint(frameRect.size.width, frameRect.size.height)];
	[rightEdge lineToPoint:NSMakePoint((frameRect.size.width - _bevelDepth), (frameRect.size.height - _bevelDepth))];
	[rightEdge lineToPoint:NSMakePoint((frameRect.size.width - _bevelDepth), _bevelDepth)];

	[bottomEdge moveToPoint:frameRect.origin];
	[bottomEdge lineToPoint:NSMakePoint(frameRect.size.width, frameRect.origin.y)];
	[bottomEdge lineToPoint:NSMakePoint((frameRect.size.width - _bevelDepth), _bevelDepth)];
	[bottomEdge lineToPoint:NSMakePoint((frameRect.origin.x + _bevelDepth), (frameRect.origin.y + _bevelDepth))];

	[[NSColor colorWithCalibratedWhite:0.5 alpha:0.5] set];
	[leftEdge fill];
	[[NSColor colorWithCalibratedWhite:0.0 alpha:0.5] set];
	[topEdge fill];
	[[NSColor colorWithCalibratedWhite:0.5 alpha:0.5] set];
	[rightEdge fill];
	[[NSColor colorWithCalibratedWhite:1.0 alpha:0.6] set];
	[bottomEdge fill];

	[[[self subviews] objectAtIndex:0] setNeedsDisplay:YES];
}

- (BOOL)mouseDownCanMoveWindow {
	return NO;
}

- (void)dealloc {
	[super dealloc];
}

@end