/*
 *	ITKit
 *	ITCoreGraphicsHacks.h
 *
 *	Header to import to work with private CoreGraphics API.
 *
 *	Copyright (c) 2005 by iThink Software.
 *	All Rights Reserved.
 *
 *	$Id$
 *
 */

typedef void * CGSGenericObj;
typedef CGSGenericObj CGSValueObj;
typedef void * CGSConnectionID;
typedef void * CGSWindowID;
typedef struct CGStyle *CGStyleRef;
typedef struct CGShadowStyle {
	unsigned int version;
	float elevation;
	float azimuth;
	float ambient;
	float height;
	float radius;
	float saturation;
} CGShadowStyle;
typedef unsigned char CGSBoolean;
enum {
	kCGSFalse = 0,
	kCGSTrue = 1
};

typedef enum {
        CGSTagExposeFade	= 0x0002,   // Fade out when Expose activates.
        CGSTagNoShadow		= 0x0008,   // No window shadow.
        CGSTagTransparent	= 0x0200,   // Transparent to mouse clicks.
        CGSTagSticky		= 0x0800,   // Appears on all workspaces.
} CGSWindowTag;

extern void CGStyleRelease(CGStyleRef style);
extern void CGSReleaseObj(void *obj);
extern void CGContextSetStyle(CGContextRef c, CGStyleRef style);
extern void CGStyleRelease(CGStyleRef style);
extern CGStyleRef CGStyleCreateShadow(const CGShadowStyle *shadow);
extern CGSValueObj CGSCreateCString(const char *string);
extern CGSValueObj CGSCreateBoolean(CGSBoolean boolean);
extern CGError CGSSetWindowProperty(const CGSConnectionID cid, CGSWindowID wid, const CGSValueObj key, const CGSValueObj value);

extern CGError CGSSetWindowWarp(const CGSConnectionID cid, CGSWindowID wid, int w,int h, float *mesh);
extern CGError CGSSetWindowTransform(const CGSConnectionID cid, CGSWindowID wid, CGAffineTransform transform);

extern OSStatus CGSGetWindowTags(const CGSConnectionID cid, const CGSWindowID wid, CGSWindowTag *tags, int thirtyTwo);
extern OSStatus CGSSetWindowTags(const CGSConnectionID cid, const CGSWindowID wid, CGSWindowTag *tags, int thirtyTwo);
extern OSStatus CGSClearWindowTags(const CGSConnectionID cid, const CGSWindowID wid, CGSWindowTag *tags, int thirtyTwo);

@interface NSApplication (ITCoreGraphicsHacks)
- (CGSConnectionID)contextID;
@end