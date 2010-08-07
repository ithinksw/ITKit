/*
 *	ITKit
 *	ITTextFieldCell.h
 *
 *	Custom NSTextFieldCell subclass that casts a shadow.
 *
 *	Copyright (c) 2010 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITTextFieldCell : NSTextFieldCell {
	BOOL castsShadow;
	float shadowAzimuth;
	float shadowAmbient;
	float shadowHeight;
	float shadowRadius;
}

- (BOOL)castsShadow;
- (void)setCastsShadow:(BOOL)newSetting;

- (float)shadowElevation; /* Light source elevation in degrees. Always 45.0 */
- (void)setShadowElevation:(float)newElevation; /* NOOP */

- (float)shadowAzimuth; /* Light source azimuth in degrees. Defaults to 90.0 */
- (void)setShadowAzimuth:(float)newAzimuth;

- (float)shadowAmbient; /* Amount of ambient light. Defaults to 0.0 */
- (void)setShadowAmbient:(float)newAmbient;

- (float)shadowHeight; /* Height above the canvas. Defaults to 1.0 */
- (void)setShadowHeight:(float)newHeight;

- (float)shadowRadius; /* Blur radius. Defaults to 4.0 */
- (void)setShadowRadius:(float)newRadius;

- (float)shadowSaturation; /* Maximum saturation. Always 1.0 */
- (void)setShadowSaturation:(float)newSaturation; /* NOOP */

@end