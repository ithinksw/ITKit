#import "ITImageCell.h"


@implementation ITImageCell


- (id)initImageCell:(NSImage *)image
{
    if ( (self = [super initImageCell:image]) ) {
        _scalesSmoothly = YES;
    }
    NSLog(@"foo");
    return self;
}



- (void)drawWithFrame:(NSRect)rect inView:(NSView *)controlView
{
    NSImageInterpolation interpolation;

    if ( _scalesSmoothly ) {
        interpolation = [[NSGraphicsContext currentContext] imageInterpolation];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    }
    
    [super drawWithFrame:rect inView:controlView];

    if ( _scalesSmoothly ) {
        [[NSGraphicsContext currentContext] setImageInterpolation:interpolation];
    }
}

- (BOOL)scalesSmoothly
{
    return _scalesSmoothly;
}

- (void)setScalesSmoothly:(BOOL)flag
{
    _scalesSmoothly = flag;
    [[self controlView] setNeedsDisplay:YES];
}


@end
