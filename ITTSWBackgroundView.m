#import "ITGrayRoundedView.h"


@implementation ITGrayRoundedView

- (id)initWithFrame:(NSRect)frameRect
{
    if ( (self = [super initWithFrame:frameRect]) ) {
        _path = [[NSBezierPath bezierPath] retain];
    }
    
    return self;
}

- (void)drawRect:(NSRect)theRect
{
    float vh = NSHeight(theRect);
    float vw = NSWidth(theRect);

    [_path autorelease];
    _path = [[NSBezierPath bezierPath] retain];

    [_path moveToPoint:NSMakePoint( 0.0, (vh - 24.0) )];	  //  first point
    [_path curveToPoint:NSMakePoint( 24.0, vh )
         controlPoint1:NSMakePoint( 0.0, (vh - 11.0) )
         controlPoint2:NSMakePoint( 11.0, vh )];   		  //  top-left curve
    [_path lineToPoint:NSMakePoint( (vw - 24.0), vh )];    //  top line
    [_path curveToPoint:NSMakePoint( vw, (vh - 24.0) )
         controlPoint1:NSMakePoint( (vw - 11.0), vh )
         controlPoint2:NSMakePoint( vw, (vh - 11.0) )];   //  top-right curve
    [_path lineToPoint:NSMakePoint( vw, 24.0 )];           //  right line
    [_path curveToPoint:NSMakePoint( (vw - 24.0), 0.0 )
         controlPoint1:NSMakePoint( vw, 11.0 )
         controlPoint2:NSMakePoint( (vw - 11.0), 0.0 )];  //  bottom-right curve
    [_path lineToPoint:NSMakePoint( 24.0, 0.0 )];          //  bottom line
    [_path curveToPoint:NSMakePoint( 0.0, 24.0 )
         controlPoint1:NSMakePoint( 11.0, 0.0 )
         controlPoint2:NSMakePoint( 0.0, 11.0 )];         //  bottom-left curve
    [_path closePath];									  //  left line

    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.15] set];
    [_path fill];
}

- (BOOL)isOpaque
{
    return NO;
}

@end
