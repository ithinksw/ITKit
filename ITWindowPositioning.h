/*
 *	ITKit
 *  ITWindowPositioning
 *    Protocol which defines methods for window positioning presets.
 *
 *  Original Author : Kent Sutherland <joseph.spiros@ithinksw.com>
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */


typedef enum {
    ITWindowPositionLeft,
    ITWindowPositionCenter,
    ITWindowPositionRight,
} ITHorizontalWindowPosition;

typedef enum {
    ITWindowPositionTop,
    ITWindowPositionMiddle,
    ITWindowPositionBottom,
} ITVerticalWindowPosition;


@protocol ITWindowPositioning

- (ITVerticalWindowPosition)verticalPosition;
- (void)setVerticalPosition:(ITVerticalWindowPosition)newPosition;
- (ITHorizontalWindowPosition)horizontalPosition;
- (void)setHorizontalPosition:(ITHorizontalWindowPosition)newPosition;
- (float)screenPadding;
- (void)setScreenPadding:(float)newPadding;
- (int)screenNumber;
- (void)setScreenNumber:(int)newNumber;

@end
