/*
 *	ITKit
 *	ITWindowEffect.h
 *
 *	Protocol and abstract superclass for performing effects on windows.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITKit/ITWindowPositioning.h>

@class ITTransientStatusWindow;

#define EFFECT_FPS 30.0
#define DEFAULT_EFFECT_TIME 0.75

typedef enum {
	ITWindowHiddenState,
	ITWindowAppearingState,
	ITWindowVisibleState,
	ITWindowVanishingState
} ITWindowVisibilityState;

@protocol ITWindowEffect

+ (NSString *)effectName;
+ (NSDictionary *)supportedPositions;
+ (unsigned int)listOrder;
- (void)performAppear;
- (void)performVanish;
- (void)cancelAppear;
- (void)cancelVanish;

@end

@protocol ITWindowMotility

- (ITWindowVisibilityState)visibilityState;
- (void)setVisibilityState:(ITWindowVisibilityState)newState;
- (float)effectProgress;
- (void)setEffectProgress:(float)newProgress;

@end

@interface ITWindowEffect : NSObject <ITWindowEffect> {
	NSWindow <ITWindowPositioning, ITWindowMotility> *_window;
	float _effectTime;
	float _effectSpeed;
	ITVerticalWindowPosition _verticalPosition;
	ITHorizontalWindowPosition _horizontalPosition;
	NSTimer *_effectTimer;
	BOOL __idle;
	BOOL __shouldReleaseWhenIdle;
}

+ (NSArray *)effectClasses;

// Designated initializer
- (id)initWithWindow:(NSWindow *)window;

- (NSWindow *)window;

- (void)setWindow:(NSWindow *)newWindow;

- (void)setWindowVisibility:(ITWindowVisibilityState)visibilityState;

- (float)effectTime;
- (void)setEffectTime:(float)newTime;

- (void)releaseWhenIdle;

@end