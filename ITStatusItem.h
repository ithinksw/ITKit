/*
 *	ITKit
 *  ITStatusItem
 *    NSStatusItem subclass which reduces suckage
 *
 *  Original Author : Joseph Spiros <joseph.spiros@ithinksw.com>
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */

/*
 *	This subclass does 4 things to approximate NSMenuExtra's functionality:
 *
 *  1. Makes the status item smarter about highlighting.
 *  2. Allows you to set an alternate (inverted) image.
 *  3. Eliminates the pre-Jaguar shadow behind a normal status item.
 *  4. If you use an image AND title, the text will be made slightly smaller
 *     to resemble the visual interface of an NSMenuExtra.
 *
 *  Note:  In order to have the shadow not overlap the bottom of the
 *  menubar, Apple moves the image up one pixel.  Since that shadow is
 *  no longer drawn, please adjust your images DOWN one pixel to compensate.
 *
 */


#import <Cocoa/Cocoa.h>


@interface ITStatusItem : NSStatusItem
{
}

// Use this to create a new retained status item.
// It will appear in the system status bar, and
// default to YES for its highlightMode.
- (id)initWithStatusBar:(NSStatusBar*)statusBar withLength:(float)length;

// These allow you to use an alternate (selected) image for your status item.
- (NSImage*) alternateImage;
- (void) setAlternateImage:(NSImage*)image;


@end
