//
//  ITSplashView.h
//  SplashScreen
//
//  Created by Kent Sutherland on 11/22/04.
//  Copyright 2004 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ITSplashView : NSView
{
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
