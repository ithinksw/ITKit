/*
 *	ITKit
 *	ITSplashView.h
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITSplashView : NSView {
	NSImage *_image;
	NSProgressIndicator *_progress;
	NSTextField *_text;
}

- (void)stopAnimation;
- (NSProgressIndicator *)progressIndicator;
- (NSImage *)image;
- (NSString *)string;
- (void)setImage:(NSImage *)image;
- (void)setString:(NSString *)text;
- (void)loadControlsFromPath:(NSString *)path;

@end