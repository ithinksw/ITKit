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

/*
 *	This subclass does 3 things:
 *
 *  1. Makes the status item smarter about highlighting.
 *  2. Allows you to set an inverted (alternate) image.
 *  3. Eliminates the pre-Jaguar shadow behind a normal status item.
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

// The following have been redefined as to supply compliance with Jaguar (10.2)'s MenuExtras that have both titles and images. Continue to use them as though you would on a NSStatusItem, everything will be done for you automatically.
- (void) setImage:(NSImage*)image;
- (NSString*) title;
- (void) setTitle:(NSString*)title;

@end
