//
//  ITGrayRoundedView.m
//  ITKit
//
//  Created by Matt L. Judy on Wed Jan 22 2003.
//  Copyright (c) 2003 NibFile.com. All rights reserved.
//

#import "ITGrayRoundedView.h"


@implementation ITGrayRoundedView

- (void)drawRect:(NSRect)theRect
{
    NSBezierPath *path = [NSBezierPath bezierPath];
    float vh = NSHeight(theRect);
    float vw = NSWidth(theRect);
    [path moveToPoint:NSMakePoint( 0.0, (vh - 24.0) )];	  //  first point
    [path curveToPoint:NSMakePoint( 24.0, vh )
         controlPoint1:NSMakePoint( 0.0, (vh - 11.0) )
         controlPoint2:NSMakePoint( 11.0, vh )];   		  //  top-left curve
    [path lineToPoint:NSMakePoint( (vw - 24.0), vh )];    //  top line
    [path curveToPoint:NSMakePoint( vw, (vh - 24.0) )
         controlPoint1:NSMakePoint( (vw - 11.0), vh )
         controlPoint2:NSMakePoint( vw, (vh - 11.0) )];   //  top-right curve
    [path lineToPoint:NSMakePoint( vw, 24.0 )];           //  right line
    [path curveToPoint:NSMakePoint( (vw - 24.0), 0.0 )
         controlPoint1:NSMakePoint( vw, 11.0 )
         controlPoint2:NSMakePoint( (vw - 11.0), 0.0 )];  //  bottom-right curve
    [path lineToPoint:NSMakePoint( 24.0, 0.0 )];          //  bottom line
    [path curveToPoint:NSMakePoint( 0.0, 24.0 )
         controlPoint1:NSMakePoint( 11.0, 0.0 )
         controlPoint2:NSMakePoint( 0.0, 11.0 )];         //  bottom-left curve
    [path closePath];									  //  left line

    [[NSColor colorWithCalibratedWhite:0.0 alpha:0.15] set];
    [path fill];
}

- (BOOL)isOpaque
{
    return NO;
}

@end
