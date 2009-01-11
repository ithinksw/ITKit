/*
 *	ITKit
 *	ITCoreImageWindowEffect.h
 *
 *	Effect subclass which performs a Core Image ripple effect on a window.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>
#import <ITKit/ITWindowEffect.h>
#import "ITCoreGraphicsHacks.h"
#import <QuartzCore/QuartzCore.h>

@interface CICGSFilter : NSObject
{
    void *_cid;
    unsigned int _filter_id;
}

+ (id)filterWithFilter:(CIFilter *)filter connectionID:(CGSConnectionID)cid;
- (id)initWithFilter:(CIFilter *)filter connectionID:(CGSConnectionID)cid;
- (void)dealloc;
- (void)setValue:(id)value forKey:(NSString *)key;
- (void)setValuesForKeysWithDictionary:(NSDictionary *)dict;
- (int)addToWindow:(CGSWindowID)windowID flags:(unsigned int)flags;
- (int)removeFromWindow:(CGSWindowID)windowID;
- (id)description;
@end

@interface ITCoreImageWindowEffect : ITWindowEffect {
	NSWindow *_effectWindow;
	CIFilter *_effectFilter;
	CICGSFilter *_windowFilter;
	BOOL _ripple;
}

@end