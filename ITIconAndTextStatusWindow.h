/*
 *	ITKit
 *	ITIconAndTextStatusWindow.h
 *
 *	ITTransientStatusWindow subclass to show an icon and text.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITKit/ITTransientStatusWindow.h>

@interface ITIconAndTextStatusWindow : ITTransientStatusWindow {
	NSImage *_image;
}

- (void)setImage:(NSImage *)newImage;
- (void)buildTextWindowWithString:(NSString *)text;

@end