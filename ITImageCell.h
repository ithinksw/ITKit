/*
 *	ITKit
 *  ITImageCell
 *    Cell used by the ITImageView control.
 *
 *  Original Author : Matthew Judy <mjudy@ithinksw.com>
 *   Responsibility : Matthew Judy <mjudy@ithinksw.com>
 *
 *  Copyright (c) 2003 iThink Software.
 *  All Rights Reserved
 *
 */
 
 
#import <Cocoa/Cocoa.h>


@interface ITImageCell : NSImageCell {

    BOOL _scalesSmoothly;

    BOOL  castsShadow;
    
    float shadowElevation;
    float shadowAzimuth;
    float shadowAmbient;
    float shadowHeight;
    float shadowRadius;
    float shadowSaturation;
}

- (BOOL)scalesSmoothly;
- (void)setScalesSmoothly:(BOOL)flag;

- (BOOL)castsShadow;
- (void)setCastsShadow:(BOOL)newSetting;

- (float)shadowElevation;		/* Light source elevation in degrees.  Defaults to 45.0 */
- (void)setShadowElevation:(float)newElevation;

- (float)shadowAzimuth;			/* Light source azimuth in degrees.  Defaults to 90.0 */
- (void)setShadowAzimuth:(float)newAzimuth;

- (float)shadowAmbient;			/* Amount of ambient light.  Defaults to 0.15 */
- (void)setShadowAmbient:(float)newAmbient;

- (float)shadowHeight;			/* Height above the canvas.  Defaults to 1.0 */
- (void)setShadowHeight:(float)newHeight;

- (float)shadowRadius;			/* Blur radius.  Defaults to 4.0 */
- (void)setShadowRadius:(float)newRadius;

- (float)shadowSaturation;		/* Maximum saturation.  Defaults to 1.0 */
- (void)setShadowSaturation:(float)newSaturation;

@end