/*
 *	ITKit
 *  ITLED
 *    NSButton subclass which resembles an LED, suitable for use
 *    in applications which utilize the Metal or Pro look.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


@interface ITLEDCell : NSActionCell {

    NSColor *_ledColor;
    BOOL     _state;

}

- (NSColor *)ledColor;
- (void)setLEDColor:(NSColor *)newColor;

@end


@interface ITLED : NSControl {

}

- (NSColor *)ledColor;
- (void)setLEDColor;

@end
