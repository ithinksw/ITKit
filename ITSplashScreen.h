/*
 *	ITKit
 *	ITSplashScreen.h
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@class ITSplashWindow, ITSplashView;

@interface ITSplashScreen : NSObject {
	NSTimer *_fadeTimer;
	ITSplashWindow *_window;
	ITSplashView *_view;
}

+ (ITSplashScreen *)sharedController;

- (double)progressValue;
- (void)setProgressValue:(double)progress;
- (NSImage *)image;
- (void)setImage:(NSImage *)image;
- (NSString *)string;
- (void)setString:(NSString *)string;
- (void)setSettingsPath:(NSString *)path;

- (void)showSplashWindow;
- (void)closeSplashWindow;

@end