/*
 *	ITKit
 *	ITWindowPositioning.h
 *
 *	Protocol which defines methods for window positioning presets.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

typedef enum {
    ITWindowPositionLeft = 0,
    ITWindowPositionCenter = 1,
    ITWindowPositionRight = 2
} ITHorizontalWindowPosition;

typedef enum {
    ITWindowPositionTop = 0,
    ITWindowPositionMiddle = 1,
    ITWindowPositionBottom = 2
} ITVerticalWindowPosition;

@protocol ITWindowPositioning

- (NSScreen *)screen;
- (void)setScreen:(NSScreen *)newScreen;
- (ITVerticalWindowPosition)verticalPosition;
- (void)setVerticalPosition:(ITVerticalWindowPosition)newPosition;
- (ITHorizontalWindowPosition)horizontalPosition;
- (void)setHorizontalPosition:(ITHorizontalWindowPosition)newPosition;
- (float)screenPadding;
- (void)setScreenPadding:(float)newPadding;

@end