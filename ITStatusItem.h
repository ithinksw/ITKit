/*
 *	ITKit
 *  ITStatusItem
 *    NSStatusItem subclass which reduces suckage
 *
 *  Original Author : Joseph Spiros <joseph.spiros@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 iThink Software.
 *  All Rights Reserved
 *
 */

#import <Cocoa/Cocoa.h>


@interface ITStatusItem : NSStatusItem
{
}

- (id)initWithStatusBar:(NSStatusBar*)statusBar withLength:(float)length;

- (NSImage*) alternateImage;
- (void) setAlternateImage:(NSImage*)image;

@end
