#import "ITTSWBackgroundView.h"


#define RADIUS 24.0


@interface ITTSWBackgroundView (Private)
@end


@implementation ITTSWBackgroundView


- (id)initWithFrame:(NSRect)frameRect
{
    if ( (self = [super initWithFrame:frameRect]) ) {
        _path  = [[NSBezierPath bezierPath] retain];
        _color = [[NSColor blueColor] retain];
        _mode  = ITTSWBackgroundApple;
    }
    
    return self;
}

- (void)drawRect:(NSRect)rect
{
    float vh     = NSHeight(rect);
    float vw     = NSWidth(rect);
    float indent = 0.0;
    
    if ( (_mode == ITTSWBackgroundReadable) || (_mode == ITTSWBackgroundColored) ) {
        indent = 2.0;
    }
    
    NSPoint pointA = NSMakePoint( ((vw - RADIUS) - indent) , (vh - indent)            );
    NSPoint pointB = NSMakePoint( (RADIUS + indent)        , (vh - indent)            );
    NSPoint pointD = NSMakePoint( indent                   , (RADIUS + indent)        );
    NSPoint pointF = NSMakePoint( ((vw - RADIUS) - indent) , indent                   );
    NSPoint pointH = NSMakePoint( (vw - indent)            , ((vh - RADIUS) - indent) );
    
    NSPoint ctrBC  = NSMakePoint( (RADIUS + indent)        , ((vh - RADIUS) - indent) );
    NSPoint ctrDE  = NSMakePoint( (RADIUS + indent)        , (RADIUS + indent)        );
    NSPoint ctrFG  = NSMakePoint( ((vw - RADIUS) - indent) , (RADIUS + indent)        );
    NSPoint ctrHA  = NSMakePoint( ((vw - RADIUS) - indent) , ((vh - RADIUS) - indent) );
    
    /*
     *        D                    E
     *      +------------------------+
     *    C | * ctrCD        ctrEF * | F
     *      |                        |
     *    B | * ctrAB        ctrGH * | G
     *      +------------------------+
     *        A                    H
     */
    
    [_path removeAllPoints];
    
    [_path moveToPoint:pointA];                         //  first point
    [_path lineToPoint:pointB];                         //  top line
    [_path appendBezierPathWithArcWithCenter:ctrBC      //  top-left curve
                                      radius:RADIUS
                                  startAngle:90.0
                                    endAngle:180.0];
    [_path lineToPoint:pointD];                         //  left line
    [_path appendBezierPathWithArcWithCenter:ctrDE      //  bottom-left curve
                                      radius:RADIUS
                                  startAngle:180.0
                                    endAngle:270.0];
    [_path lineToPoint:pointF];                         //  top line
    [_path appendBezierPathWithArcWithCenter:ctrFG      //  top-right curve
                                      radius:RADIUS
                                  startAngle:270.0
                                    endAngle:0.0];
    [_path lineToPoint:pointH];                         //  right line
    [_path appendBezierPathWithArcWithCenter:ctrHA      //  bottom-right curve
                                      radius:RADIUS
                                  startAngle:0.0
                                    endAngle:90.0];
                                    
    if ( _mode == ITTSWBackgroundApple ) {
        [[NSColor colorWithCalibratedWhite:0.0 alpha:0.15] set];
    } else if ( _mode == ITTSWBackgroundReadable ) {
        [[NSColor colorWithCalibratedWhite:0.15 alpha:0.70] set];
    } else if ( _mode == ITTSWBackgroundColored ) {
        [_color set];
    }
    
    [_path fill];

    if ( (_mode == ITTSWBackgroundReadable) || (_mode == ITTSWBackgroundColored) ) {
        [[NSColor colorWithCalibratedWhite:0.90 alpha:1.00] set];
        [_path setLineWidth:3.0];
        [_path stroke];
    }
}

- (BOOL)isOpaque
{
    return NO;
}

- (ITTSWBackgroundMode)backgroundMode
{
    return _mode;
}

- (void)setBackgroundMode:(ITTSWBackgroundMode)newMode
{
    _mode = newMode;
    [self setNeedsDisplay:YES];
}

- (NSColor *)backgroundColor
{
    return _color;
}

- (void)setBackgroundColor:(NSColor *)newColor
{
    [_color autorelease];
    _color = [newColor copy];
    [self setNeedsDisplay:YES];
}


@end
