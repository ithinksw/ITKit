#import "ITButtonCell.h"
#import "ITTextFieldCell.h"


#define GRAY_EXTRA_PAD_H 60.0


@interface ITButtonCell (Private)
- (void)drawGrayRoundedBezelWithFrame:(NSRect)rect inView:(NSView *)controlView;
@end


@implementation ITButtonCell

- (id)init
{
    if ( ( self = [super init] ) ) {
        _subStyle = 0;
    }
    
    return self;
}



/*************************************************************************/
#pragma mark -
#pragma mark INSTANCE METHODS
/*************************************************************************/

- (void)setBezelStyle:(NSBezelStyle)bezelStyle
{
    if ( bezelStyle == ITGrayRoundedBezelStyle ) {
        _subStyle  = bezelStyle;
        bezelStyle = NSRegularSquareBezelStyle;
    } else {
        _subStyle = 0;
    }

    [super setBezelStyle:bezelStyle];
}


/*************************************************************************/
#pragma mark -
#pragma mark DRAWING METHODS
/*************************************************************************/

- (void)drawWithFrame:(NSRect)rect inView:(NSView *)controlView
{
    if ( _subStyle == ITGrayRoundedBezelStyle ) {
        [self drawGrayRoundedBezelWithFrame:rect inView:controlView];
        if ( [self attributedTitle] ) {
            NSPoint stringOrigin;
            NSSize stringSize;
            stringSize = [[self attributedTitle] size];
            stringOrigin.x = rect.origin.x + (rect.size.width - stringSize.width)/2;
            stringOrigin.y = (rect.origin.y + (rect.size.height - stringSize.height)/2) - 2;
            [controlView lockFocus];
            [[self attributedTitle] drawAtPoint:stringOrigin];
            [controlView unlockFocus];
        } else {
            [super drawInteriorWithFrame:rect inView:controlView];
        }
        [[controlView superview] setNeedsDisplay:YES];
    } else {
        [super drawWithFrame:rect inView:controlView];
    }
}

- (void)drawGrayRoundedBezelWithFrame:(NSRect)rect inView:(NSView *)controlView
{
    NSBezierPath *path   = [NSBezierPath bezierPath];
    float         ch     = rect.size.height;
    float         cw     = rect.size.width;
    float         radius = ( ch / 2 );
    NSPoint       pointA = NSMakePoint( (ch / 2)        , 0.0      );
    NSPoint       pointB = NSMakePoint( (cw - (ch / 2)) , 0.0      );
//  NSPoint       pointC = NSMakePoint( (cw - (ch / 2)) , ch       );
    NSPoint       pointD = NSMakePoint( (ch / 2)        , ch       );
    NSPoint       lCtr   = NSMakePoint( (ch / 2)        , (ch / 2) );
    NSPoint       rCtr   = NSMakePoint( (cw - (ch / 2)) , (ch / 2) );
    float         alpha  = 0.45;
    
    [path moveToPoint:pointA];
    [path lineToPoint:pointB];
    [path appendBezierPathWithArcWithCenter:rCtr
                                     radius:radius
                                 startAngle:270.0
                                   endAngle:90.0];
    [path lineToPoint:pointD];
    [path appendBezierPathWithArcWithCenter:lCtr
                                     radius:radius
                                 startAngle:90.0
                                   endAngle:270.0];

    if ( [self isHighlighted] ) {
        alpha = 0.60;
    }
    
    [[NSColor colorWithCalibratedWhite:0.15 alpha:alpha] set];
    [path fill];
}

- (BOOL)isOpaque
{
    return NO;
}

@end
