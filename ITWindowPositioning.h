/*
 *	ITKit
 *  ITWindowPositioning
 *    Protocol which defines methods for window positioning presets.
 *
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


typedef enum {
    ITWindowPositionLeft   = 0,
    ITWindowPositionCenter = 1,
    ITWindowPositionRight  = 2,
} ITHorizontalWindowPosition;

typedef enum {
    ITWindowPositionTop    = 0,
    ITWindowPositionMiddle = 1,
    ITWindowPositionBottom = 2,
} ITVerticalWindowPosition;


@protocol ITWindowPositioning

- (ITVerticalWindowPosition)verticalPosition;
- (void)setVerticalPosition:(ITVerticalWindowPosition)newPosition;
- (ITHorizontalWindowPosition)horizontalPosition;
- (void)setHorizontalPosition:(ITHorizontalWindowPosition)newPosition;
- (float)screenPadding;
- (void)setScreenPadding:(float)newPadding;
/*- (int)screenNumber;
- (void)setScreenNumber:(int)newNumber;*/

@end
