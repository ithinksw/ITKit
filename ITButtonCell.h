/*
 *	ITKit
 *  ITButtonCell
 *    Cell used by the ITButton control.
 *
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


#import <Cocoa/Cocoa.h>


typedef enum _ITBezelStyle {
    ITGrayRoundedBezelStyle  = 1001
} ITBezelStyle;


@interface ITButtonCell : NSButtonCell {

    ITBezelStyle _subStyle;

}


@end
