#import "ITTSWBackgroundView.h"


@implementation ITTSWBackgroundView

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
    
    NSPoint pointA = NSMakePoint( 24.0        , 0.0         );
//  NSPoint pointB = NSMakePoint( 0.0         , 24.0        );  reference
    NSPoint pointC = NSMakePoint( 0.0         , (vh - 24.0) );
//  NSPoint pointD = NSMakePoint( 24.0        , vh          );  reference
    NSPoint pointE = NSMakePoint( (vw - 24.0) , vh          );
//  NSPoint pointF = NSMakePoint( vw          , (vh - 24.0) );  reference
    NSPoint pointG = NSMakePoint( vw          , 24.0        );
//  NSPoint pointH = NSMakePoint( (vw - 24.0) , 0.0         );  reference

    NSPoint ctrAB  = NSMakePoint( 24.0        , 24.0        );
    NSPoint ctrCD  = NSMakePoint( 24.0        , (vh - 24.0) );
    NSPoint ctrEF  = NSMakePoint( (vw - 24.0) , (vh - 24.0) );
    NSPoint ctrGH  = NSMakePoint( (vw - 24.0) , 24.0        );
    
    /*
     *        D                    E
     *      +------------------------+
     *    C | * ctrCD        ctrEF * | F
     *      |                        |
     *    B | * ctrAB        ctrGH * | G
     *      +------------------------+
     *        A                    H
     */
    
    [_path autorelease];
    _path = [[NSBezierPath bezierPath] retain];

    [_path moveToPoint:pointA];                         //  first point
    [_path appendBezierPathWithArcWithCenter:ctrAB      //  bottom-left curve
                                      radius:24.0
                                  startAngle:90.0
                                    endAngle:180.0];
    [_path lineToPoint:pointC];                         //  left line
    [_path appendBezierPathWithArcWithCenter:ctrCD      //  top-left curve
                                      radius:24.0
                                  startAngle:180.0
                                    endAngle:270.0];
    [_path lineToPoint:pointE];                         //  top line
    [_path appendBezierPathWithArcWithCenter:ctrEF      //  top-right curve
                                      radius:24.0
                                  startAngle:270.0
                                    endAngle:0.0];
    [_path lineToPoint:pointG];                         //  right line
    [_path appendBezierPathWithArcWithCenter:ctrGH      //  bottom-right curve
                                      radius:24.0
                                  startAngle:0.0
                                    endAngle:90.0];
    [_path lineToPoint:pointA];                         //  right line
    
    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.15] set];
    [_path fill];
}

- (BOOL)isOpaque
{
    return NO;
}

@end
