/*
 *	ITKit
 *	ITTextField.h
 *
 *	Custom NSTextField subclass that uses ITTextFieldCell.
 *
 *	Copyright (c) 2005 iThink Software
 *
 */

#import <Cocoa/Cocoa.h>

@interface ITTextField : NSTextField {

}

- (BOOL)castsShadow;
- (void)setCastsShadow:(BOOL)newSetting;

- (float)shadowElevation; /* Light source elevation in degrees. Defaults to 45.0 */
- (void)setShadowElevation:(float)newElevation;

- (float)shadowAzimuth; /* Light source azimuth in degrees. Defaults to 90.0 */
- (void)setShadowAzimuth:(float)newAzimuth;

- (float)shadowAmbient; /* Amount of ambient light. Defaults to 0.15 */
- (void)setShadowAmbient:(float)newAmbient;

- (float)shadowHeight; /* Height above the canvas. Defaults to 1.0 */
- (void)setShadowHeight:(float)newHeight;

- (float)shadowRadius; /* Blur radius. Defaults to 4.0 */
- (void)setShadowRadius:(float)newRadius;

- (float)shadowSaturation; /* Maximum saturation. Defaults to 1.0 */
- (void)setShadowSaturation:(float)newSaturation;

@end