/*
 *	ITKit
 *  ITTextField
 *    Allows shadows to be drawn under text.
 *
 *  Original Author : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Matt Judy <mjudy@ithinksw.com>
 *   Responsibility : Joseph Spiros <joseph.spiros@ithinksw.com>
 *
 *  Copyright (c) 2002 - 2003 iThink Software.
 *  All Rights Reserved
 *
 */

 
#import <Cocoa/Cocoa.h>


@interface ITTextField : NSTextField {

    BOOL  castsShadow;
    
    float shadowElevation;
    float shadowAzimuth;
    float shadowAmbient;
    float shadowHeight;
    float shadowRadius;
    float shadowSaturation;

}

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
