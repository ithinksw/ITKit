/*
 *	ITKit
 *  ITCoreGraphicsHacks
 *    Header to import to work with private CoreGraphics API
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */

/*************************************************************************/
#pragma mark -
#pragma mark CoreGraphics HACKS
/*************************************************************************/

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
    kCGSTrue  = 1
};

extern void        CGStyleRelease(CGStyleRef style);
extern void        CGSReleaseObj(void *obj);
extern void        CGContextSetStyle(CGContextRef c, CGStyleRef style);
extern void        CGStyleRelease(CGStyleRef style);
extern CGStyleRef  CGStyleCreateShadow(const CGShadowStyle *shadow);
extern CGSValueObj CGSCreateCString(const char *string);
extern CGSValueObj CGSCreateBoolean(CGSBoolean boolean);
extern CGError     CGSSetWindowProperty(const CGSConnectionID cid, CGSWindowID wid, const CGSValueObj key, const CGSValueObj value);
                                        
extern CGError CGSSetWindowWarp(const CGSConnectionID cid, CGSWindowID wid, int w,int h, float *mesh);
extern CGError CGSSetWindowTransform(const CGSConnectionID cid, CGSWindowID wid, CGAffineTransform transform);
